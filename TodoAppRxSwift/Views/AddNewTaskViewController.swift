//
//  AddNewTaskView.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/30/25.
//

import Foundation
import UIKit
class AddNewTaskViewController: UIViewController{
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskCategoryButton: UIButton!
    @IBOutlet weak var eventCategoryButton: UIButton!
    @IBOutlet weak var goalCategoryButton: UIButton!
    @IBOutlet weak var timeTextField: UITextField!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
