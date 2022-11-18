//
//  TaskListViewControllerTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 16.11.2022.
//

import XCTest
@testable import MyTasksAndTests

class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        
        sut = vc as? TaskListViewController
        sut.loadViewIfNeeded()
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
    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    //проверяем, что когда tableView загружен, DataProvider не нил
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    //проверяем, что когда контроллер загружается, делегат для tableView загружается
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    //проверяем, что когда контроллер загружается, делегат для tableView загружается
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    //проверяет, что делегатом нашего tableView и data source нашего tableView является наш DataProvider
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSource() {
        XCTAssertEqual(
            sut.tableView.delegate as? DataProvider, sut.tableView.dataSource as? DataProvider
        )
    }
}
