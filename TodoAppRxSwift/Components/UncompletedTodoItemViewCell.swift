//
//  UncompletedItemViewCell.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/26/25.
//

import Foundation
import UIKit

class UncompletedTodoItemViewCell: UITableViewCell{
    let uncompletedTodoView = UncompletedTodoItemView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUncompletedTodoView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUncompletedTodoView()
    }
    
    private func setupUncompletedTodoView(){
        contentView.addSubview(uncompletedTodoView)
        uncompletedTodoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uncompletedTodoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            uncompletedTodoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            uncompletedTodoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            uncompletedTodoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(todo: Todo){
        uncompletedTodoView.configureView(todo: todo)
    }
    
}
