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
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
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
    
    //тест на проверку успешной авторизации по токену
    // токен будет вложен в Дату -> в completionHandler -> DataTask -> urlSession
    func testSuccessfulLoginCreatesToken() {
        
        let jsonDataStub = "{\"token\": \tokenString\"}".data(using: .utf8) //создаем токен
        
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        
        let tokenExpectation = expectation(description: "Token expectation")
        
        var caughtToken: String?
        sut.login(withName: "login", password: "0000") { token, _ in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken, "tokenString")
        }
    }
    
    func testLoginInvalidJSONRetunsError() {
        mockURLSession = MockURLSession(data: Data(), urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.login(withName: "login", password: "0000") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
    
    func testLoginWhenDataIsNilRetunsError() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.login(withName: "login", password: "0000") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
    
    func testLoginWhenServerRetunsError() {
        let jsonDataStub = "{\"token\": \tokenString\"}".data(using: .utf8)
        let error = NSError(domain: "Server error", code: 404, userInfo: nil)
        
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: error)
        sut.urlSession = mockURLSession
        
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.login(withName: "login", password: "0000") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
}

extension APIClientTests {
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        
        private let mockDataTask: MockURLSessionDataTask
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
    //        return URLSession.shared.dataTask(with: url)
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}
