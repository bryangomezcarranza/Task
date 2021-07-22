//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Bryan Gomez on 7/21/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    weak var delegate: TaskCompletionDelegate?

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    

    
    
    
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
        

    }
    
    var task: Task? {
        didSet {
            guard let task = task else { return }
            updateViews(with: task)
        }
    }
    
    func updateViews(with task: Task) {
        taskNameLabel.text = task.name
        
        let imageName = task.isCompleted ? "complete" : "incomplete"
        completionButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
    
    

}
