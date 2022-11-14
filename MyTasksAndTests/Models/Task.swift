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
    
    
    init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
        self.date = Date()
    }
}
