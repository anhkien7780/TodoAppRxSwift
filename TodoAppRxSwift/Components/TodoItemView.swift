//
//  TitleTextField.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
import UIKit
import RxSwift

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
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func configureView(todo: Todo){
        switch todo.category {

        case .Task:
            self.iconImage.image = UIImage(named: "Task")
        case .Event:
            self.iconImage.image = UIImage(named: "Event")
        case .Goal:
            self.iconImage.image = UIImage(named: "Goal")
        case .None:
            self.iconImage.image = UIImage(named: "Task")
        }
        
        let taskAttributeText = NSAttributedString(string: todo.taskTitle, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue, .strikethroughColor: UIColor.black])
        self.taskTitle.attributedText = taskAttributeText
        
        if let time = todo.time {
            let attributedText = NSAttributedString(
                string: time,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue, .strikethroughColor: UIColor.black]
            )
            self.timeLabel.attributedText = attributedText
        } else{
            self.timeLabel.isHidden = true
        }
    }
    
}
