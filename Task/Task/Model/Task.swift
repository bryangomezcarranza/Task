//
//  Task.swift
//  Task
//
//  Created by Bryan Gomez on 7/21/21.
//

import Foundation

class Task: Codable {

    var name: String
    var notes: String?
    var dueDate: Date?
    var uuid: String
    var isCompleted: Bool
    
    
    init(name: String, notes: String?, dueDate: Date?, isCompleted: Bool = false, uuid: String = UUID().uuidString) {
        
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.uuid = uuid
        self.isCompleted = isCompleted
    }
    
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    
}
