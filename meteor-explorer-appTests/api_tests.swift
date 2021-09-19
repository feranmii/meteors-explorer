//
//  APITests.swift
//  meteor-explorer-appTests
//
//  Created by Feranmi on 19/09/2021.
//
@testable import meteor_explorer_app
import XCTest

class APITests: XCTestCase {
    func testMeteorsFetch() throws {
        let viewModel = MeteorsViewModel()
        let expectation = expectation(description: "Waiting for data")
        viewModel.fetchMeteors(onSuccess: {
            XCTAssert(!viewModel.meteors.isEmpty)
            expectation.fulfill()
        }, onFailure: { _ in
            XCTFail()
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 5)
    }
}
