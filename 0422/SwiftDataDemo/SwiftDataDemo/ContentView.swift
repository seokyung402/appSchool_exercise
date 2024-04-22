//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by seokyung on 4/22/24.
//

import SwiftUI

class Task: Identifiable {
    var id: UUID
    var title: String
    var completed: Bool
    
    init(id: UUID = UUID(), title: String, completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}

struct ContentView: View {
    @State var tasks: [Task] = [
        Task(title: "Title1"),
        Task(title: "Title2"),
        Task(title: "Title3"),
        Task(title: "Title4"),
        Task(title: "Title5"),
        Task(title: "Title6")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                        Spacer()
                        if task.completed {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addTask) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    func addTask() {
        let newTask = Task(title: "New Task")
        self.tasks.append(newTask)
    }
}

#Preview {
    ContentView()
}
