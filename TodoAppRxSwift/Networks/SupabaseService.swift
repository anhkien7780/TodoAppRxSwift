//
//  SupabaseService.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/30/25.
//

import Foundation
import Supabase
import RxSwift
import RxCocoa

class SupabaseService {
    
    static let supabaseServices = SupabaseService()
    let supabaseClient: SupabaseClient
    
    private init() {
        supabaseClient = SupabaseService.create()
    }
    static func create() -> SupabaseClient{
        let client = SupabaseClient(supabaseURL: URL(string: "https://wjtcovdhnkzblowkavfy.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndqdGNvdmRobmt6Ymxvd2thdmZ5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MTI2NTY0MiwiZXhwIjoyMDY2ODQxNjQyfQ.3f8f9zFGpoySjVi3XgaCXmbzsEWoMD0JrGkseJ2jNi0")
        return client
    }
    
    func loadSupabaseTodoData() -> Single<[Todo]>{
        return Single.create { single in
            Task{
                do {
                    let todos: [Todo] = try await self.supabaseClient
                        .from("todos")
                        .select()
                        .execute()
                        .value
                    
                    single(.success(todos))
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func addSupabaseTodoDate(todo: Todo) -> Single<[Todo]>{
        return Single.create{ single in
            Task{
                do {
                    let inserted: [Todo] = try await self.supabaseClient
                        .from("todos")
                        .insert(todo)
                        .select()
                        .execute()
                        .value
                    single(.success(inserted))
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func toogleTodoItemCompletion(todo: Todo) -> Single<[Todo]>{
        return Single.create{ single in
            Task {
                do {
                    let updated: [Todo] = try await
                    self.supabaseClient
                        .from("todos")
                        .update(["is_completed": !todo.isCompleted])
                        .eq("id", value: todo.id)
                        .select()
                        .execute()
                        .value
                    single(.success(updated))
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
}




