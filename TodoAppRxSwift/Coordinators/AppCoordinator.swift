//
//  AppCoordinator.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAddNewTask()
    }
    
    func showTodoList(){
        let listTodoScreenVC = ListTodoScreenViewController()
        navigationController.pushViewController(listTodoScreenVC, animated: false)
    }
    
    func showAddNewTask(){
        let addNewTaskVC = AddNewTaskViewController()
        navigationController.pushViewController(addNewTaskVC, animated: false)
    }
}
