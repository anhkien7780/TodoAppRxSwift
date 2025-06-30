//
//  ListTodoScreenView.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
import UIKit
import RxSwift

class ListTodoScreenViewController: UIViewController{
    @IBOutlet weak var addNewTaskButton: UIButton!
    @IBOutlet private weak var currentDateLabel: UILabel!
    
    var viewModel: TodoListViewModel!
    weak var coordinator: AppCoordinator?
    
    init(viewModel: TodoListViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let cellHeight: CGFloat = 80
    let disposedBag = DisposeBag()
    
    private var uncompletedTableHeightConstraint: NSLayoutConstraint!
    private var completedTableHeightConstraint: NSLayoutConstraint!
    
    
    private let uncompletedItemTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 80
        table.separatorInset = .zero
        table.layoutMargins = .zero
        table.separatorInsetReference = .fromCellEdges
        table.layer.cornerRadius = 16
        table.clipsToBounds = true
        return table
    }()
    private let completedTitleView: UILabel = {
        let label = UILabel()
        label.text = "Completed"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private let completedItemTableView: UITableView = {
        let table = UITableView()
        table.separatorInset = .zero
        table.layoutMargins = .zero
        table.separatorInsetReference = .fromCellEdges
        table.rowHeight = 80
        table.layer.cornerRadius = 16
        table.clipsToBounds = true
        return table
    }()
    
    private let scrollableView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let containerView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentDate()
        setupView()
        bindTableViews()
        setTableViewSizes()
        setButtonTap()
    }
    
    private func setCurrentDate(){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM dd, yyyy"
        let currentDate = Date()
        self.currentDateLabel.text = formatter.string(from: currentDate)
    }
    
    private func setupView(){
        
        [containerView, scrollableView, uncompletedItemTableView, completedTitleView, completedItemTableView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        containerView.addSubview(scrollableView)
        
        uncompletedItemTableView.register(UncompletedTodoItemViewCell.self, forCellReuseIdentifier: "UncompletedTodoCell")
        
        completedItemTableView.register(TodoItemViewCell.self, forCellReuseIdentifier: "TodoCell")
        
        [uncompletedItemTableView,
         completedTitleView,
         completedItemTableView].forEach{
            scrollableView.addSubview($0)
        }
        
        uncompletedItemTableView.isScrollEnabled = false
        completedItemTableView.isScrollEnabled = false
        uncompletedTableHeightConstraint = uncompletedItemTableView.heightAnchor.constraint(equalToConstant: 0)
        uncompletedTableHeightConstraint.isActive = true
        
        completedTableHeightConstraint = completedItemTableView.heightAnchor.constraint(equalToConstant: 0)
        completedTableHeightConstraint.isActive = true
        
        scrollableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view.addSubview(containerView)
        view.bringSubviewToFront(addNewTaskButton)
        
        // Full screen scrollable content view
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            scrollableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        // Scrollable content's constraints
        NSLayoutConstraint.activate([
            uncompletedItemTableView.topAnchor.constraint(equalTo: scrollableView.topAnchor, constant: 156),
            uncompletedItemTableView.leadingAnchor.constraint(equalTo: scrollableView.leadingAnchor),
            uncompletedItemTableView.trailingAnchor.constraint(equalTo: scrollableView.trailingAnchor),
            uncompletedItemTableView.widthAnchor.constraint(equalTo: scrollableView.widthAnchor),
            
            completedTitleView.topAnchor.constraint(equalTo: uncompletedItemTableView.bottomAnchor, constant: 24),
            completedTitleView.leadingAnchor.constraint(equalTo: scrollableView.leadingAnchor),
            
            completedItemTableView.topAnchor.constraint(equalTo: completedTitleView.bottomAnchor, constant: 24),
            completedItemTableView.leadingAnchor.constraint(equalTo: scrollableView.leadingAnchor),
            completedItemTableView.trailingAnchor.constraint(equalTo: scrollableView.trailingAnchor),
            completedItemTableView.bottomAnchor.constraint(equalTo: scrollableView.bottomAnchor),
        ])
    }
    
    private func bindTableViews(){
        viewModel.uncompletedTodos
            .bind(to: uncompletedItemTableView.rx.items(cellIdentifier: "UncompletedTodoCell", cellType: UncompletedTodoItemViewCell.self)){ row, item, cell in
                cell.configure(todo: item)
                cell.onCheckTapped = {
                    self.viewModel.toggleTodoCompletion(item)
                }
            }
            .disposed(by: disposedBag)
        
        viewModel.completedTodos
            .bind(to: completedItemTableView.rx.items(cellIdentifier: "TodoCell", cellType: TodoItemViewCell.self)){ row, item, cell in
                cell.configure(todo: item)
                cell.onCheckTapped = {
                    self.viewModel.toggleTodoCompletion(item)
                }
            }
            .disposed(by: disposedBag)
    }
    
    private func setTableViewSizes(){
        viewModel.uncompletedTodos
            .map { CGFloat($0.count) * self.cellHeight }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] totalHeight in
                self?.uncompletedTableHeightConstraint.constant = totalHeight
            })
            .disposed(by: disposedBag)
        
        viewModel.completedTodos
            .map { CGFloat($0.count) * self.cellHeight }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] totalHeight in
                self?.completedTableHeightConstraint.constant = totalHeight
            })
            .disposed(by: disposedBag)
        
    }
    
    private func setButtonTap() {
        addNewTaskButton.rx.tap
            .subscribe(
                onNext: {[weak self] in
                    self?.coordinator?.navigateToAddNewTaskView()
                }
            )
            .disposed(by: disposedBag)
    }
}
