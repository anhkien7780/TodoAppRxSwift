//
//  TitleTextField.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
import UIKit


class TodoItemView: UIView {
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        guard let view = self.loadViewByNibName(nibName: "TodoItemView") else {return}
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        taskTitle.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func configureView(todo: Todo){
        switch todo.category {
        case .Event:
            self.iconImage.image = UIImage(named: "Event")
        case .Task:
            self.iconImage.image = UIImage(named: "Task")
        case .Goal:
            self.iconImage.image = UIImage(named: "Goal")
        case .None:
            self.iconImage.image = UIImage(named: "Task")
        }
        self.taskTitle.text = todo.taskTitle
        if todo.time != nil{
            self.timeLabel.text = todo.time
            self.timeLabel.numberOfLines = 0
        } else {
            timeLabel.isHidden = true
        }
        if todo.isCompleted{
            self.checkBox.setImage(UIImage(named: "Checked=True"), for: .normal)
        } else {
            self.checkBox.setImage(UIImage(named: "Checked=False"), for: .normal)
        }
    }
    
}
