//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case asEntered = "Default"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case completed = "Not Done"
}

struct SortedToDoList: View {
    @Query var toDos: [ToDo]
    @Environment(\.modelContext) var modelContext
    let sortSelection: SortOption
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch self.sortSelection {
        case .asEntered:
            _toDos = Query()
        case .alphabetical:
            _toDos = Query(sort: \.item)
        case .chronological:
            _toDos = Query(sort: \.dueDate)
        case .completed:
            _toDos = Query(filter: #Predicate { $0.isCompleted == false })
        }
    }
    
    var body: some View {
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
                                .font(.title3)
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
    }
}

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    @State private var sortSelection: SortOption = .asEntered
    
    var body: some View {
        NavigationStack {
            SortedToDoList(sortSelection: sortSelection)
                .navigationTitle("To Do List")
                .sheet(isPresented: $sheetIsPresented, content: {
                    NavigationStack {
                        DetailView(toDo: ToDo())
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            sheetIsPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Picker("", selection: $sortSelection) {
                            ForEach(SortOption.allCases, id: \.self) { sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
