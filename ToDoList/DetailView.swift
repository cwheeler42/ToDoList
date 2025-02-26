//
//  DetailView.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import SwiftUI

struct DetailView: View {
    @State var toDoText: String
    @State private var reminderIsOn = false
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State private var notes = ""
    @State private var isCompleted = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            TextField("Enter To Do here:", text: $toDoText)
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
                    // TODO: save()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        DetailView(toDoText: "")
    }
}
