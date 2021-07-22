//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Bryan Gomez on 7/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskController.shared.loadFromPersistanceStore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        let task = TaskController.shared.tasks[indexPath.row]
        
        cell.updateViews(with: task)
        cell.delegate = self
        //cell.textLabel?.text = task.name
        return cell
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? TaskDetailViewController else { return }
        
        
        if segue.identifier == "toTaskDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let selectedTask = TaskController.shared.tasks[indexPath.row]
            destinationVC.task = selectedTask
            
        }
    }
    
}

extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateViews(with: task)
        
        
        
    }
    
    
}
