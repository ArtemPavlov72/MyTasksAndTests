//
//  TaskCell.swift
//  MyTasksAndTests
//
//  Created by Артем Павлов on 18.11.2022.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    func configure(withTask task: Task, done: Bool = false) {
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
        } else {
            titleLabel.text = task.title
            locationLabel.text = task.location?.name
            
            if let date = task.date {
                let dateString = dateFormatter.string(from: date)
                dateLabel.text = dateString
            }
        }
        
    }
}

