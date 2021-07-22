//
//  TaskController.swift
//  Task
//
//  Created by Bryan Gomez on 7/21/21.
//

import Foundation

class TaskController {
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?){
        let createNewTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(createNewTask)
        
        saveToPersistanceStore()
    }
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        saveToPersistanceStore()
    }
    
    func toggleIsComplete(task: Task) {
        
        task.isCompleted.toggle()
        
        saveToPersistanceStore()
    }
    func delete(task: Task) {
        
        guard let index = tasks.firstIndex(of: task) else { return}
        self.tasks.remove(at: index)
        
        saveToPersistanceStore()
        
    }
    
    // creating a local path to a local file.
    func createPersistanceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) // users home directory.
        // every time we save, we are saving the  whole thing over again.
        let fileURL = url[0].appendingPathComponent("Tasks.json") // making it unic by passsing a pathComponent
        return fileURL // we now have a path to that file
    }
    
    // saving it to that URL path file.
    func saveToPersistanceStore() {
        //since this can throw we have a place to catch the error
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: createPersistanceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    // loading data back from the file path we created.
    func loadFromPersistanceStore() {
        do {
            let data = try Data(contentsOf: createPersistanceStore()) // getting it from same url
            tasks = try JSONDecoder().decode([Task].self, from: data) // decode an array of playlsit from the data in file.
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }

}
