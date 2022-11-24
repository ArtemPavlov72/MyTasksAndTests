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
        
        //мы создавали ячейку через сториборд, поэтому работаем с ним
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as! TaskCell
        
        XCTAssertNotNil(cell.titleLabel)
        
    }
    
    //проверяем действительно ли наш titleLabel находится внутри view
    
    func testCellHasTitleLabelInContentView() {
      
        
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
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
