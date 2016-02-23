//
//  DiceyTests.swift
//  DiceyTests
//
//  Created by Blaise Schaeffer on 2/16/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import XCTest
@testable import Dicey

var cup = Cup(withNumDice: 5)


class DiceyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var dice = [Int]()
        for die in cup.myDice {
            dice.append(die.getFaceValue())
        }
        XCTAssertEqual(dice, [2,5,1,4,2])
        
    }
    
    func testExample2() {
        XCTAssertEqual(cup.roll(), [3,2,3,2,6])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
