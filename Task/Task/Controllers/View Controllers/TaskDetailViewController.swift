//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Bryan Gomez on 7/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var task: Task?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()


    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = taskNameTextField.text, !title.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else { return }
        let date = taskDueDatePicker.date
        
        if let task = task {
            TaskController.shared.update(task: task, name: title, notes: notes, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: title, notes: notes, dueDate: date)
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func dueDatePickerChanged(_ sender: Any) {
        date = taskDueDatePicker.date
        
    }
    
    func updateViews() {
        guard let task = task else { return }
        
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate!
    }
    
}
