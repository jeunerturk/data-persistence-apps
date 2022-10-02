//
//  ContentView.swift
//  ToDoApp-UserDefaults
//
//  Created by Umut Can Ertürk on 1.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newTodo = ""
    @State private var todoArray: [TodoItem] = []
    private let userdefaultsKey = "key"
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Todo..", text: $newTodo)
                        .padding()
                    Button("Add") {
                        if newTodo != "" {
                            self.todoArray.append(TodoItem(todo: newTodo))
                            newTodo = ""
                            saveData()
                        }
                    }.padding()
                }
                List {
                    
                    
                    ForEach(todoArray) {todoItem in
                        Text(todoItem.todo)
                    }.onDelete(perform: deleteTodo)
                    
                    
                    
                    
                }
            }.navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
        }.onAppear(perform: loadData)
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey:userdefaultsKey) {
            if let todoSavedArray = try? JSONDecoder().decode(Array<TodoItem>.self, from: data) {
                self.todoArray = todoSavedArray
                
            }
        }
        
        
    }
    
    
    private func saveData() {
        UserDefaults.standard.set(try? JSONEncoder().encode(self.todoArray), forKey: userdefaultsKey)
    }
    private func deleteTodo(at offset: IndexSet) {
        self.todoArray.remove(atOffsets: offset)
        saveData()
    }
    
    
}

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    let todo: String
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
