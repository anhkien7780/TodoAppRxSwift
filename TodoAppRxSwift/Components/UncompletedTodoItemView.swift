//
//  UncompletedTodoItemView.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/26/25.
//

import Foundation
import UIKit
import RxSwift

class UncompletedTodoItemView: UIView{
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        guard let view = self.loadViewByNibName(nibName: "UncompletedTodoItemView") else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
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
    }
}
