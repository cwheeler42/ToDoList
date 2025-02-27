//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @State private var sheetIsPresented = false

    @Environment(\.modelContext) var modelContext
    @Query var toDos: [ToDo]

    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) { toDo in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                                .onTapGesture {
                                    toDo.isCompleted.toggle()
                                    guard let _ = try? modelContext.save() else {
                                        print("‼️ ERROR: Save on .toggle on ToDoListView did not work.")
                                        return
                                    }
                                }
                            
                            NavigationLink {
                                DetailView(toDo: toDo)
                            } label: {
                                Text(toDo.item)
                            }
                            .swipeActions {
                                // Fancier button
                                Button(role: .destructive) {
                                    modelContext.delete(toDo)
                                    guard let _ = try? modelContext.save() else {
                                        print("‼️ ERROR: Save on ToDoListView() did not work.")
                                        return
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                
                                // Simple button
                                //                        Button("Delete", role: .destructive) {
                                //                            modelContext.delete(toDo)
                                //                            guard let _ = try? modelContext.save() else {
                                //                                print("‼️ ERROR: Save on ToDoListView() did not work.")
                                //                                return
                                //                            }
                                //                        }
                            }
                        }
                        .font(.title2)
                        
                        HStack {
                            Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                            if toDo.reminderIsOn {
                                Image(systemName: "calendar.badge.clock")
                                    .symbolRenderingMode(.multicolor)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .sheet(isPresented: $sheetIsPresented, content: {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            })
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
