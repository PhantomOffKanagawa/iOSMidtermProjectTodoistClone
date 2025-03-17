//
//  Tasks.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/17/25.
//

import Foundation

// Struct for loading task from JSON
struct Task: Codable {
    let title: String
    let category: String
    let categoryColor: String
    let hasRecurring: Bool?
    let progress: String?
}

// Struct for loading days from JSON
struct Day: Identifiable, Codable, Hashable, Equatable {
    static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let tasks: [Task]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
}
