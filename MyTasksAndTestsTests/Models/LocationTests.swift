//
//  LocationTests.swift
//  MyTasksAndTestsTests
//
//  Created by Артем Павлов on 15.11.2022.
//

import XCTest
import CoreLocation
@testable import MyTasksAndTests

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
       
    }
    
    func testInitSetsName() {
        let location = Location(name: "Foo")
        
        XCTAssertEqual(location.name, "Foo")
    }

    // проверяем, что у нас устанивливаются координаты
    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        
        let location = Location(name: "Foo", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    

    
    

}
