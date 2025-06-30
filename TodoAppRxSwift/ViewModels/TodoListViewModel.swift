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
    let disposeBag = DisposeBag()

    init() {
        SupabaseService
            .supabaseServices
            .loadSupabaseTodoData()
            .subscribe(
                onSuccess: { todos in
                    let uncompleted = todos.filter{
                        $0.isCompleted == false
                    }
                    let completed = todos.filter{
                        $0.isCompleted == true
                    }
                    self.uncompletedTodos.accept(uncompleted)
                    self.completedTodos.accept(completed)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func addNewTodo(_ todo: Todo){
        SupabaseService
            .supabaseServices
            .addSupabaseTodoDate(todo: todo)
            .subscribe(onSuccess: { newTodo in
                self.uncompletedTodos.accept(self.uncompletedTodos.value + newTodo)
            })
            .disposed(by: disposeBag)
    }

    func toggleTodoCompletion(_ todo: Todo) {
        SupabaseService.supabaseServices
            .toogleTodoItemCompletion(todo: todo)
            .subscribe(onSuccess: { updatedTodos in
                guard let updatedTodo = updatedTodos.first else { return }
                
                // XÓA ở cả 2 danh sách (phòng trùng)
                self.removeTodo(withId: updatedTodo.id, from: self.completedTodos)
                self.removeTodo(withId: updatedTodo.id, from: self.uncompletedTodos)
                
                // THÊM lại vào đúng danh sách
                if updatedTodo.isCompleted {
                    var completed = self.completedTodos.value
                    completed.append(updatedTodo)
                    self.completedTodos.accept(completed)
                } else {
                    var uncompleted = self.uncompletedTodos.value
                    uncompleted.append(updatedTodo)
                    self.uncompletedTodos.accept(uncompleted)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func removeTodo(withId id: UUID, from relay: BehaviorRelay<[Todo]>) {
        var current = relay.value
        if let index = current.firstIndex(where: { $0.id == id }) {
            current.remove(at: index)
            relay.accept(current)
        }
    }
}

