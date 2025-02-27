//
//  ToDo.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    var notes = ""
    var isCompleted = false
    
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}

extension ToDo {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(ToDo(item: "First Item", reminderIsOn: true, dueDate: Date.now + 60*60*24, notes: "This is a note", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Item #2", reminderIsOn: true, dueDate: Date.now + 60*60*24*3, notes: "", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Something The Third", reminderIsOn: false, dueDate: Date.now, notes: "", isCompleted: true))
        container.mainContext.insert(ToDo(item: "Go Bananas", reminderIsOn: true, dueDate: Date.now + 60*60*24*7, notes: "Make sure you go bananas regularly", isCompleted: false))
        
        return container
    }
}
