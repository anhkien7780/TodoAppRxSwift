//
//  TodoItemViewCell.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/26/25.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TodoItemViewCell: UITableViewCell{
    let todoView = TodoItemView()
    var disposeBag = DisposeBag()
    
    var onCheckTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTodoView()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTodoView()
    }
    
    private func setupTodoView(){
        contentView.addSubview(todoView)
        todoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            todoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            todoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(todo: Todo){
        todoView.configureView(todo: todo)
        
        todoView.checkBox.rx.tap.bind{
            [weak self] in
            self?.onCheckTapped?()
        }
        .disposed(by: disposeBag)
    }
}
