//
//  TaskListViewControllerTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 16.11.2022.
//

import XCTest
@testable import MyTasksAndTests

class TaskListViewControllerTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
    }
    
    //проверяем действительно ли вьюконтроллер после загрузки имеет внутри себя tableview
    //        func testTableViewNotNilWhenViewIsLoaded() {
    //            let sut = TaskListViewController()
    //
    //            //проверяем, что view загрузился
    //            _ = sut.view // sut.loadViewIfNeeded
    //
    //            XCTAssertNotNil(sut.tableView)
    //        }
    
    //для работы со сторибоард
    func testTableViewNotNilWhenViewIsLoaded() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        
        let sut = vc as! TaskListViewController
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView)
    }
}
