//
//  favourites_tests.swift
//  meteor-explorer-appTests
//
//  Created by Feranmi on 19/09/2021.
//

@testable import meteor_explorer_app
import XCTest

class favourites_tests: XCTestCase {
    let meteorModel = MeteorModel(name: "Meteor #1", id: "101", mass: "100", year: "2021", geolocation: Geolocation(coordinates: [1.3, 2.2]))
    let meteorModel2 = MeteorModel(name: "Meteor #2", id: "102", mass: "200", year: "2021", geolocation: Geolocation(coordinates: [1.33, 2.12]))
    let meteorModel3 = MeteorModel(name: "Meteor #3", id: "103", mass: "300", year: "2021", geolocation: Geolocation(coordinates: [1.43, 2.52]))

    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: "favourites")
    }

    func testAddingFavorites() throws {
        FavoritesManager.toggleFavorites(meteorModel) { result in
            XCTAssertTrue(result && FavoritesManager.favourites.count > 0)
        }
    }

    func testRemovingFavorites() {
        FavoritesManager.toggleFavorites(meteorModel) { _ in }
        FavoritesManager.toggleFavorites(meteorModel2) { _ in }
        FavoritesManager.toggleFavorites(meteorModel) { result in
            XCTAssertTrue(!result && FavoritesManager.favourites.count == 1)
        }
    }

    func testCheckFavoriteExists() {
        FavoritesManager.toggleFavorites(meteorModel) { _ in }
        FavoritesManager.toggleFavorites(meteorModel2) { _ in }

        XCTAssertTrue(FavoritesManager.favouriteCheck(id: meteorModel.id))
    }

    func testCheckFavoriteDoesNotExist() {
        FavoritesManager.toggleFavorites(meteorModel) { _ in } // favorite the item
        FavoritesManager.toggleFavorites(meteorModel) { _ in } // unfovorite the item
        FavoritesManager.toggleFavorites(meteorModel3) { _ in }

        XCTAssertTrue(!FavoritesManager.favouriteCheck(id: meteorModel.id))
    }
}
