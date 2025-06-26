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
}
