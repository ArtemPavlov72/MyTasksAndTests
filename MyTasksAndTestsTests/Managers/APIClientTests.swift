//
//  APIClientTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 28.11.2022.
//

import XCTest
@testable import MyTasksAndTests

class APIClientTests: XCTestCase {

    var mockURLSession: MockURLSession!
    var sut: APIClient!
    
    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        
    }
    
    private func loginUser() {
        let completionHandler = { (token: String?, error: Error?) in }
        sut.login(withName: "name", password: "%qwerty", completionHandler: completionHandler)
    }

    //когда пользователь пытается залогинеться, то обращение к серверу использует правильный хост
    func testLoginUsesCorrectHost() {
        loginUser()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    
    func testLoginUsesCorrectPath() {
        loginUser()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }
    
    func testLoginUsesExpectedQueryParametrs() {
        loginUser()
        
        guard let quaryItems = mockURLSession.urlComponents?.queryItems else {
            XCTFail()
            return
        }
        
        let urlQueryItemName = URLQueryItem(name: "name", value: "name")
        let urlQueryItemPassword = URLQueryItem(name: "password", value: "%qwerty")
        
        XCTAssertTrue(quaryItems.contains(urlQueryItemName))
        XCTAssertTrue(quaryItems.contains(urlQueryItemPassword))
    }
}

extension APIClientTests {
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
