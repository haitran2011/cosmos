//
//  ValidatorTests.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/8/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import XCTest

@testable import cosmos

class ValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmailValidator() {
        let validator = EmailValidator()
        validator.input = "test@gmail.com"
        XCTAssertTrue(validator.validateWithError(nil))
        
        validator.input = "test+1@gmail.com"
        XCTAssertTrue(validator.validateWithError(nil))
        
        validator.input = "test"
        XCTAssertFalse(validator.validateWithError(nil))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
