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

    let favoritesManager = FavoritesManager()
    
    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: "favourites")
    }
    
    override class func tearDown() {
        UserDefaults.standard.removeObject(forKey: "favourites")
    }

    func testAddingFavorites() throws {
        favoritesManager.toggleFavorites(meteorModel) { result in
            XCTAssertTrue(result && favoritesManager.favourites.count > 0)
        }
    }

    func testRemovingFavorites() {
        favoritesManager.toggleFavorites(meteorModel) { _ in }
        favoritesManager.toggleFavorites(meteorModel2) { _ in }
        favoritesManager.toggleFavorites(meteorModel) { result in
            XCTAssertTrue(!result && favoritesManager.favourites.count == 1)
        }
    }

    func testCheckFavoriteExists() {
        favoritesManager.toggleFavorites(meteorModel) { _ in }
        favoritesManager.toggleFavorites(meteorModel2) { _ in }

        XCTAssertTrue(favoritesManager.favouriteCheck(id: meteorModel.id))
    }

    func testCheckFavoriteDoesNotExist() {
        favoritesManager.toggleFavorites(meteorModel) { _ in } // favorite the item
        favoritesManager.toggleFavorites(meteorModel) { _ in } // unfovorite the item
        favoritesManager.toggleFavorites(meteorModel3) { _ in }

        XCTAssertTrue(!favoritesManager.favouriteCheck(id: meteorModel.id))
    }
}
