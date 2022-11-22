//
//  DataProviderTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 18.11.2022.
//

import XCTest
@testable import MyTasksAndTests

class DataProviderTests: XCTestCase {

    var sut: DataProvider!
    var tableView: UITableView!
    
    //чтобы получить tableView с нашего сториборда, мы должны получить контроллер
    var controller: TaskListViewController!
    
    override func setUpWithError() throws {
        sut = DataProvider()
        sut.taskManager = TaskManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
    }

    override func tearDownWithError() throws {

    }

// проверяем, действительно ли в нашем tableView 2 секции, так как у нас одна секция - это текущие задачи, а вторая - выполненные
    func testNumberOfSectionsIsTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    // проверяем, что количество задач, которые нам надо выполнить равно количеству строк в первой секции tableView
    func testNumberOfRowsInSectionZeroIsTasksCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        tableView.reloadData() // при нескольких взаимодействиях с таблицей, чтобы не было ошибки, нам необходимо в ручную обновить таблицу
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberOfRowsInSectionOneIsDoneTasksCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.checkTask(at: 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    //проверяем, какую ячейку мы получаем в методе cellForRowAt indexPath
    func testCellForRowAtIndexPathReturnsTaskCell() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TaskCell)
    }
    
    func testCellForRowAtIndexPathDequeuesCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    //проверяем, срабатывает ли у нас метод configure первой секции
    func testCellForRowInSectionZeroCallsConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        XCTAssertEqual(cell.task, task)
    }
    
    //проверяем, срабатывает ли у нас метод configure второй секции
    func testCellForRowInSectionFirstCallsConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let task = Task(title: "Foo")
        let task2 = Task(title: "Bar")
        sut.taskManager?.add(task: task)
        sut.taskManager?.add(task: task2)
        sut.taskManager?.checkTask(at: 0)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        XCTAssertEqual(cell.task, task)
    }
    
}

extension DataProviderTests {
    //подменяем обычный tableView на наш мок объект
    class MockTableView: UITableView {
        //данное свойство будет говорить, что мы переиспользуем ячейку или нет
        var cellIsDequeued = false
        
        static func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 20, y: 44, width: 374, height: 818), style: .plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockTaskCell: TaskCell {
        var task: Task?
        
        override func configure(withTask task: Task) {
            self.task = task
        }
    }
}
