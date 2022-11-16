//
//  TaskManagerTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 15.11.2022.
//

import XCTest
@testable import MyTasksAndTests

class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!
    
    override func setUpWithError() throws {
        sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // колличество задач при создании менеджера должно быть = 0
    func testInitTaskManagerWithZeroTasks() {
        XCTAssertEqual(sut.tasksCount, 0)
    }

    // колличество задач при создании менеджера должно быть = 0
    func testInitTaskManagerWithZeroDoneTasks() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    // проверяем, что при добавлении задачи tasksCount увеличится на 1
    func testAddTaskIncreasesTasksCount() {
        let task = Task(title: "Foo")
        
        sut.add(task: task)
        
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    //проверяем, что добавленный task - это тот самый task по добавленному индексу
    func testTaskAtIndexIsAddedTask() {
        let task = Task(title: "Foo")
        
        sut.add(task: task)
        
        let returnedTask = sut.task(at:  0)
        
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    //проверяем, что если помечаем задачу выполненной, то счетчики количества задач меняются
    func testCheckTaskAtIndexChangesCounts() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    
    //проверяем, что выполненный task удаляется из задач
    func testCheckTaskRemovedFromTasks() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    func testDoneTaskAtReturnsCheckedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    //проверям метод, который удаляет заметку из двух массивов
    func testRemoveAllResultsCountsBeZero() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Bar"))
        
        sut.checkTask(at: 0)
        
        sut.removeAll()
        
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTasksCount == 0)
    }
    
    //проверяем, что в массиве хранятся разные значения
    func testAddingSameObjectDoesNotIncrementCount() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Foo"))
        
        XCTAssertTrue(sut.tasksCount == 1)
    }
}
