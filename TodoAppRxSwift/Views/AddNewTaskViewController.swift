//
//  AddNewTaskView.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/30/25.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddNewTaskViewController: UIViewController{
    var selectedCategory: Category = .Task
    
    var viewModel: TodoListViewModel = TodoListViewModel()
    
    init(viewModel: TodoListViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskCategoryButton: UIButton!
    @IBOutlet weak var eventCategoryButton: UIButton!
    @IBOutlet weak var goalCategoryButton: UIButton!
    @IBOutlet weak var timeTextField: UITextField!
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    let hiddenTextField = UITextField()
    let suffixTimeButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 55).isActive = true
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return view
    }()
    let suffixTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.setImage(UIImage(named: "clock"), for: .normal)
        return button
    }()
    let suffixDateButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 55).isActive = true
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return view
    }()
    let suffixDateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.setImage(UIImage(named: "calendar"), for: .normal)
        return button
    }()
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setButtonTaps()
        bindDatePicker()
    }
    
    private func setupView(){
        [suffixDateButton, suffixTimeButton, suffixDateButtonContainer, suffixTimeButtonContainer].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        suffixDateButtonContainer.addSubview(suffixDateButton)
        suffixTimeButtonContainer.addSubview(suffixTimeButton)
        
        NSLayoutConstraint.activate([
            suffixDateButton.centerXAnchor.constraint(equalTo: suffixDateButtonContainer.centerXAnchor),
            suffixDateButton.centerYAnchor.constraint(equalTo: suffixDateButtonContainer.centerYAnchor),
            
            suffixTimeButton.centerXAnchor.constraint(equalTo: suffixTimeButtonContainer.centerXAnchor),
            suffixTimeButton.centerYAnchor.constraint(equalTo: suffixTimeButtonContainer.centerYAnchor),
        ])
        
        dateTextField.rightView = suffixDateButtonContainer
        dateTextField.rightViewMode = .always
        
        timeTextField.rightView = suffixTimeButtonContainer
        timeTextField.rightViewMode = .always
        
        saveButton.layer.cornerRadius = 28
        saveButton.clipsToBounds = true
        
        // Date picker as hidden text field
        hiddenTextField.inputView = datePicker
        hiddenTextField.isHidden = true
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Xong", style: .done, target: self, action: #selector(hideDatePicker))
        toolbar.setItems([doneButton], animated: false)
        hiddenTextField.inputAccessoryView = toolbar
        view.addSubview(hiddenTextField)
    }
    
    private func setButtonTaps(){
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        taskCategoryButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.selectedCategory = .Task
                self?.taskCategoryButton.alpha = 0.3
                self?.eventCategoryButton.alpha = 1
                self?.goalCategoryButton.alpha = 1
            })
            .disposed(by: disposeBag)
        eventCategoryButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.selectedCategory = .Event
                self?.taskCategoryButton.alpha = 1
                self?.eventCategoryButton.alpha = 0.3
                self?.goalCategoryButton.alpha = 1
            })
            .disposed(by: disposeBag)
        goalCategoryButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.selectedCategory = .Goal
                self?.taskCategoryButton.alpha = 1
                self?.eventCategoryButton.alpha = 1
                self?.goalCategoryButton.alpha = 0.3
            })
            .disposed(by: disposeBag)
        saveButton.rx.tap
            .subscribe(onNext: {[weak self] in
                var todo = Todo(
                    taskTitle: self?.taskTextField.text ?? "",
                    category: self?.selectedCategory ?? .Task,
                    isCompleted: false
                )
                if let time = self?.timeTextField.text {
                    todo.time = time
                }
                if let date = self?.dateTextField.text {
                    todo.date = date
                }
                
                if let taskTitle = self?.taskTextField.text {
                    if taskTitle.isEmpty != true {
                        self?.viewModel.addNewTodo(todo)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        suffixDateButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showDatePicker()
            })
            .disposed(by: disposeBag)
        suffixTimeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showDatePicker()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindDatePicker(){
        datePicker.rx.date
            .subscribe(onNext: { [weak self] selectedDate in
                guard let self = self else { return }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                self.dateTextField.text = dateFormatter.string(from: selectedDate)
                
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH:mm"
                self.timeTextField.text = timeFormatter.string(from: selectedDate)
            })
            .disposed(by: disposeBag)
    }
    @objc func showDatePicker() {
        hiddenTextField.becomeFirstResponder()
    }
    
    @objc func hideDatePicker() {
        hiddenTextField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
