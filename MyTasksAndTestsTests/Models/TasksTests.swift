//
//  TasksTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 14.11.2022.
//

import XCTest
@testable import MyTasksAndTests

class TasksTests: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task) // не nill
    }
    
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task) // не nill
    }

    //когда у нас дан заголовок - мы его устанавливаем
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        //проверяем, что в task установлен заголовок и он равен "Foo"
        XCTAssertEqual(task.title, "Foo")
    }

    //когда у нас дано описание - мы его устанавливаем
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        //проверяем, что description равно Bar
        XCTAssertTrue(task.description == "Bar")
    }
    
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Foo",
                        description: "Bar",
                        location: location)
        
        //проверяем, что location, который мы создали - это тот же самый location, который есть в task
        XCTAssertEqual(location, task.location)
    }
}
