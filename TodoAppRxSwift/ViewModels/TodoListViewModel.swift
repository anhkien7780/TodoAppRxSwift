//
//  TodoListViewModel.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/26/25.
//

import Foundation
import RxSwift
import RxCocoa

class TodoListViewModel {
    let uncompletedTodos: BehaviorRelay<[Todo]> = BehaviorRelay(value: [])
    let completedTodos: BehaviorRelay<[Todo]> = BehaviorRelay(value: [])

    init() {
        let uncompleted = [
            Todo(taskTitle: "Walk dog", category: .Task, isCompleted: false),
            Todo(taskTitle: "Buy groceries", category: .Task, isCompleted: false)
        ]
        
        let completed = [
            Todo(taskTitle: "Call mom", category: .Event, isCompleted: true),
            Todo(taskTitle: "Finish homework", category: .Goal, isCompleted: true),
            Todo(taskTitle: "Call mom", category: .Event, isCompleted: true),
            Todo(taskTitle: "Finish homework", category: .Goal, isCompleted: true),
            Todo(taskTitle: "Call mom", category: .Event, isCompleted: true),
            Todo(taskTitle: "Finish homework", category: .Goal, isCompleted: true),
            Todo(taskTitle: "Call mom", category: .Event, isCompleted: true),
            Todo(taskTitle: "Finish homework", category: .Goal, isCompleted: true),
            Todo(taskTitle: "Call mom", category: .Event, isCompleted: true),
            Todo(taskTitle: "Finish homework", category: .Goal, isCompleted: true)
        ]
        
        uncompletedTodos.accept(uncompleted)
        completedTodos.accept(completed)
    }

    func toggleTodoCompletion(_ todo: Todo) {
        var newTodo = todo
        newTodo.isCompleted.toggle()
        
        if todo.isCompleted {
            var completed = completedTodos.value
            var uncompleted = uncompletedTodos.value
            
            if let index = completed.firstIndex(where: { $0.taskTitle == todo.taskTitle }) {
                completed.remove(at: index)
                uncompleted.append(newTodo)
            }
            
            completedTodos.accept(completed)
            uncompletedTodos.accept(uncompleted)
        } else {
            var completed = completedTodos.value
            var uncompleted = uncompletedTodos.value
            
            if let index = uncompleted.firstIndex(where: { $0.taskTitle == todo.taskTitle }) {
                uncompleted.remove(at: index)
                completed.append(newTodo)
            }
            
            completedTodos.accept(completed)
            uncompletedTodos.accept(uncompleted)
        }
    }
}

