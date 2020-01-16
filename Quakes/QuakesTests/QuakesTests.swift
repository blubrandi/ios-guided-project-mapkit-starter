//
//  QuakesTests.swift
//  QuakesTests
//
//  Created by Paul Solt on 10/31/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import XCTest
@testable import Quakes

class QuakesTests: XCTestCase {
    
    func testQuakeJSONParsing() {
        
        // Red, Green, Refactor
        // red = failing test
        // green = implement logic to pass test
        // refactor = clean up code or reorganize
        
        let decoder = JSONDecoder()
        do {
            let quake = try decoder.decode(Quake.self, from: quakeData)
            // Test(Expected, Actual)
            XCTAssertEqual(1.29, quake.magnitude, accuracy: 0.001) //add accuracy to test that it's the actual value
        } catch {
            XCTFail("Error decoding: \(error)")
        }
    }
}
