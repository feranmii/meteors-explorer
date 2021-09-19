//
//  FavoritesViewModel.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation

final class FavoritesViewModel {
    var favorites: MeteorsListModel = []
    
    init() {
        getFavorites()
    }
    
    func getFavorites() {
        favorites = FavoritesManager.favourites
    }
}
