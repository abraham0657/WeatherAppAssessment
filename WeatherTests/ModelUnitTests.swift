//
//  ModelUnitTests.swift
//  WeatherTests
//
//  Created by Abraham Tesfamariam on 11/3/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import XCTest
@testable import Weather

class ModelUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*
     @description: tests the City model
     */
    func testCityObject() {
        let city = City.init(name: "Chicago", country: "US")
        XCTAssertTrue(city.name == "Chicago")
        XCTAssertTrue(city.country == "US")
    }
    
}
