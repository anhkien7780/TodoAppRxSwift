//
//  AppCoordinator.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()
    var todoListViewModel: TodoListViewModel = TodoListViewModel()
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        showTodoList()
    }
    
    func showTodoList(){
        let listTodoScreenVC = ListTodoScreenViewController(viewModel: todoListViewModel)
        listTodoScreenVC.coordinator = self
        navigationController.viewControllers = [listTodoScreenVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateToAddNewTaskView(){
        let addNewTaskVC = AddNewTaskViewController(viewModel: todoListViewModel)
        addNewTaskVC.modalPresentationStyle = .pageSheet
        addNewTaskVC.modalTransitionStyle = .coverVertical
        navigationController.present(addNewTaskVC, animated: true, completion: nil)
    }
}
