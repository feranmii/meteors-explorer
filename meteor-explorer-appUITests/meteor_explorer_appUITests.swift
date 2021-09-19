//
//  meteor_explorer_appUITests.swift
//  meteor-explorer-appUITests
//
//  Created by Feranmi on 17/09/2021.
//

@testable import meteor_explorer_app
import XCTest

class meteor_explorer_appUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testForOpeningMap() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables["meteors-tableView"].cells.element(boundBy: 0).tap()

        XCTAssertTrue(app.maps.element(boundBy: 0).exists)
    }

    func testForTogglingFavorite() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables["meteors-tableView"].cells.element(boundBy: 0).tap()

        app.navigationBars.buttons["favorite-button"].tap()

        app.navigationBars.buttons["back-button"].tap()
    }

    func testForSwitchSortingModes() throws {
        let app = XCUIApplication()
        app.launch()

        app.segmentedControls["meteors-sort-control"].buttons.element(boundBy: 1).tap()
        app.segmentedControls["meteors-sort-control"].buttons.element(boundBy: 0).tap()
    }
}
