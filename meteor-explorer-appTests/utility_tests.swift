//
//  utility_tests.swift
//  meteor-explorer-appTests
//
//  Created by Feranmi on 19/09/2021.
//

@testable import meteor_explorer_app
import XCTest

class utility_tests: XCTestCase {
    func testDateFormat() throws {
        let dateString = "1992-01-01T00:00:00.000"
        let formattedDate = formatDate(dateString: dateString)
        XCTAssertNotEqual(formattedDate, "")
    }

    func testMassToKgConversion() throws {
        let mass = "1560"
        let convertedMass = convertMassToKg(mass: mass)
        XCTAssertNotEqual(convertedMass, "")
    }
}
