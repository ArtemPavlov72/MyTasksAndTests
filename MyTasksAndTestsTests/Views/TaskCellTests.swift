//
//  TaskCellTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 24.11.2022.
//

import XCTest
@ testable import MyTasksAndTests

class TaskCellTests: XCTestCase {
    
    var cell: TaskCell!

    override func setUpWithError() throws {
        //мы создавали ячейку через сториборд, поэтому работаем с ним
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }

    override func tearDownWithError() throws {
        
    }
    
    //ячейка должна отображать какую-нибудь информацию
    //чтобы отображать информацию, нам пригодятся ярлыки
    //проверим, есть ли у ячейки заголовок (свойство titleLabel)
    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    //проверяем действительно ли наш titleLabel находится внутри view
    func testCellHasTitleLabelInContentView() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellHasLocationLabelInContentView() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellHasDateLabelInContentView() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    // тесты конфигурации ячейки
    
    func testConfigureSetsTitle() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        XCTAssertEqual(cell.titleLabel.text, task.title)
    }
    
    func testConfigureSetsDate() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = task.date
        let dateString = df.string(from: date!)
        
        XCTAssertEqual(cell.dateLabel.text, dateString)
    }
    
    func testConfigureLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Bar", location: location)
        cell.configure(withTask: task)
        
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
    }
    
    //проверяем, что выполненные задачи - зачеркнуты
    private func configureCellWithTask() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
    }
    
    func testDoneTaskShouldStrikeThrought() {
        configureCellWithTask()
        
        //меняем стиль отображения
        let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    }
    
    //проверяем, что у выполненной задачи лэйбел с датой равен nil
    func testDoneTaskDateLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.dateLabel)
    }

    //проверяем, что у выполненной задачи лэйбел с location равен nil
    func testDoneTaskLocationLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.locationLabel)
    }
}

extension TaskCellTests {
    
    //создаем фейковый dataSource
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
    
    }
    
}
