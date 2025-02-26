//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import SwiftUI

struct ToDoListView: View {
    var toDos = ["Learn Swift",
                 "Build Apps",
                 "Change the World",
                 "Bring the Awesome",
                 "Take a Vacation"]

    @State private var sheetIsPresented = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink {
                        DetailView(toDoText: toDo)
                    } label: {
                        Text(toDo)
                    }
                }
            }
            .listStyle(.plain)
            .sheet(isPresented: $sheetIsPresented, content: {
                NavigationStack {
                    DetailView(toDoText: "")
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
}
