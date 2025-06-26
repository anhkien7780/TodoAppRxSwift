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
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configureView(iconImage: UIImage?, taskTitle: String, time: String? = nil, isCompleted: Bool){
        self.iconImage.image = iconImage
        self.taskTitle.text = taskTitle
        if let time {
            self.timeLabel.text = time
        } else {
            timeLabel.isHidden = true
        }
        if isCompleted{
            self.checkBox.setImage(UIImage(named: "Checked=True"), for: .normal)
        } else {
            self.checkBox.setImage(UIImage(named: "Checked=False"), for: .normal)
        }
    }
    
}
