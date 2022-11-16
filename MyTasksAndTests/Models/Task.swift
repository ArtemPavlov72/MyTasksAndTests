//
//  Task.swift
//  MyTasksAndTests
//
//  Created by Артем Павлов on 14.11.2022.
//

import Foundation

struct Task {
    let title: String
    let description: String?
    private(set) var date: Date?
    let location: Location?
    
    init(title: String,
         description: String? = nil,
         location: Location? = nil) {
        self.title = title
        self.description = description
        self.date = Date()
        self.location = location
    }
}

// так как у нас есть date, то когда мы создаем две одинакомые заметки и пытаемся добавить их в массив tasks, они добавляютс, так как имеется маааленькая разница в дате (милили секунды разные).
// поэтому мы делаем свой метод сравнения экземпляров тасков
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title,
           lhs.description == rhs.description,
           lhs.location == rhs.location {
            return true
        }
        return false
    }
}
