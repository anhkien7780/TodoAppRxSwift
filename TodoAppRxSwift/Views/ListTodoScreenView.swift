//
//  ListTodoScreenView.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
import UIKit

class ListTodoScreenView: UIViewController{
    @IBOutlet weak var currentDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentDate()
    }
    
    private func setCurrentDate(){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM dd, yyyy"
        let currentDate = Date()
        self.currentDateLabel.text = formatter.string(from: currentDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
