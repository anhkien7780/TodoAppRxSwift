//
//  TodoListViewModel.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/26/25.
//

import Foundation
import RxSwift
import RxCocoa

class TodoListViewModel{
    let uncompletedTodos: Observable<[Todo]>
    let completedTodos: Observable<[Todo]>
    
    init() {
        let uncompleted = [
            Todo(taskTitle: "Walk dog", category: .Task, isCompleted: false),
            Todo(taskTitle: "Buy groceries", category: .Task, isCompleted: false)
        ]
        
        let completed = [
            Todo(taskTitle: "Call mom", category: .Event, isCompleted: true),
            Todo(taskTitle: "Finish homework", category: .Goal, isCompleted: true)
        ]
        
        self.uncompletedTodos = Observable.just(uncompleted)
        self.completedTodos = Observable.just(completed)
    }
}
