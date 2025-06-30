//
//  Todo.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
struct Todo : Codable{
    var id: UUID = UUID()
    let taskTitle: String
    var date: String? = nil
    var time: String? = nil
    let category: Category
    var isCompleted: Bool
    var note: String? = nil
    
    enum CodingKeys: String, CodingKey{
        case id
        case taskTitle = "task_title"
        case date, time, category
        case isCompleted = "is_completed"
        case note
    }
}
