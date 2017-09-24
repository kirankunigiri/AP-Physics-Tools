//
//  AP_Physics_ToolsTests.swift
//  AP Physics ToolsTests
//
//  Created by Kiran Kunigiri on 9/23/17.
//  Copyright © 2017 Kiran Kunigiri. All rights reserved.
//

import XCTest
@testable import AP_Physics_Tools

class AP_Physics_ToolsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // MARK: - Tests
        let number1 = Uncertain(num: 1.53, uncertainty: 0.05)
        let number2 = Uncertain(num: 0.67, uncertainty: 0.02)
        
        // Addition
        let resultAddition = number1 + number2
        XCTAssertTrue(resultAddition.description == "2.2 \\pm 0.07")
        
        let resultSubtraction = number1 - number2
        XCTAssertTrue(resultSubtraction.description == "0.86 \\pm 0.07")
        
        let resultMultiplication = number1 * number2
        XCTAssertTrue(resultMultiplication.description == "1.03 \\pm 0.06")
        
        let resultDivision = number1/number2
        XCTAssertTrue(resultDivision.description == "2.29 \\pm 0.14")
    }
    
    func testPerformanceExample() {
        self.measure {
            testExample()
        }
    }
    
}
