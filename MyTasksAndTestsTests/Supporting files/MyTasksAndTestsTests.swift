//
//  MyTasksAndTestsTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 14.11.2022.
//

import XCTest
@testable import MyTasksAndTests

class MyTasksAndTestsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewControllerIsTaskViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers.first as! TaskListViewController
        
        XCTAssertTrue(rootViewController is TaskListViewController)
    }

}
