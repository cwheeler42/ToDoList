//
//  DetailView.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var toDo: ToDo
    
    @State private var item = ""
    @State private var reminderIsOn = false
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State private var notes = ""
    @State private var isCompleted = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            TextField("Enter To Do here:", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder:", isOn: $reminderIsOn)
                .listRowSeparator(.hidden)

            DatePicker("Date:", selection: $dueDate)
                .listRowSeparator(.hidden)
                .disabled(!reminderIsOn)
            
            Text("Notes:")
                .padding(.top)
            TextField("Notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed:", isOn: $isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
            
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    // move data from local vars to ToDo object
                    toDo.item = item
                    toDo.reminderIsOn = reminderIsOn
                    toDo.dueDate = dueDate
                    toDo.notes = notes
                    toDo.isCompleted = isCompleted
                    modelContext.insert(toDo)
                    guard let _ = try? modelContext.save() else {
                        print("‼️ ERROR: Save on DetailView() did not work.")
                        return
                    }
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear() {
            item = toDo.item
            reminderIsOn = toDo.reminderIsOn
            dueDate = toDo.dueDate
            notes = toDo.notes
            isCompleted = toDo.isCompleted
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo())
            .modelContainer(for: ToDo.self, inMemory: true)
    }
}
