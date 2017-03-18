//
//  cosmosTests.swift
//  cosmosTests
//
//  Created by Tue Nguyen on 5/23/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import XCTest

@testable import cosmos

class cosmosTests: XCTestCase {
    var client: APIClient!
    
    override func setUp() {
        super.setUp()
        client = APIClient(baseURLString: Constant.ServiceURL)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testDateFormat() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: "2016-02-03 04:56:26")
        XCTAssertNotNil(date)
    }
    func testLogin() {
        let asyncExpectation = expectation(description: "Aync login function")
        var loginResponse:LoginResponse?
        client.login("tue@grr.la", password: "123456") { (response, error) in
            loginResponse = response
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(loginResponse, "Resonse is null")
        }
    }
    
    func getAPIKey() -> String? {
        let asyncExpectation = expectation(description: "Aync login function")
        var loginResponse:LoginResponse?
        client.login("tue@grr.la", password: "123456") { (response, error) in
            loginResponse = response
            asyncExpectation.fulfill()
        }
        var apiKey: String?
        
        waitForExpectations(timeout: 10) { (error) in
            apiKey = loginResponse?.apiKey
        }
        
        return apiKey
    }
    
    func testRestaurantDetails() {
        let apiKey = getAPIKey()
        client.accessToken = apiKey
        
        var restaurantDetailsResponse: RestaurantDetailsResponse?
        let asyncExpectation = expectation(description: "Aync function")
        client.restaurantDetails { (response, error) in
            restaurantDetailsResponse = response
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(restaurantDetailsResponse?.result?.id, "Error when getting restaurant details")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
