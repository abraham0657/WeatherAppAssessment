//
//  WeatherServiceUnitTest.swift
//  WeatherTests
//
//  Created by Abraham Tesfamariam on 11/3/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherServiceUnitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*
     @description: tests service call for fetching cities
     @param: void
     @return: void
     */
    func testWeatherServiceCityCall() {
        let serviceExpectation = expectation(description: "WeatherService.fetchCity")
        let service = WeatherService()
        let url = URL(string: ConfigConstants.cityURL.rawValue)
        
        service.makeServiceCall(url: url!) { (data, error) in
            if error == nil {
                serviceExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            
        }
    }
    
    /*
     @description: tests service call for fetching weather data
     @param: void
     @return: void
     */
    func testWeatherServiceDataCall() {
        let serviceExpectation = expectation(description: "WeatherService.fetchData")
        let service = WeatherService()
        let url = URL(string: ConfigConstants.weatherURL.rawValue + "Chicago" + ConfigConstants.weatherURLAPIKey.rawValue)
        
        service.makeServiceCall(url: url!) { (data, error) in
            if error == nil {
                serviceExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            
        }
    }
    
}
