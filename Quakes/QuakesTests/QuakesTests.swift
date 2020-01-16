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
        decoder.dateDecodingStrategy = .millisecondsSince1970
        do {
            let quake = try decoder.decode(Quake.self, from: quakeData)
            let date = Date(timeIntervalSince1970: 1388620296020.0 / 1000)
            
            // Test(Expected, Actual)
            XCTAssertEqual(1.29, quake.magnitude, accuracy: 0.001) //add accuracy to test that it's the actual value
            XCTAssertEqual("10km SSW of Idyllwild, CA", quake.place)
            XCTAssertEqual(date, quake.time)
        } catch {
            XCTFail("Error decoding: \(error)")
        }
    }
}
