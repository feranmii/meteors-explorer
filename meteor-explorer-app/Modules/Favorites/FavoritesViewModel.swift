//
//  FavoritesViewModel.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation

final class FavoritesViewModel {
    var favorites: MeteorsListModel = []

    public func getFavorites(onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        if let data = UserDefaults.standard.data(forKey: "favourites") {
            do {
                let decoder = JSONDecoder()

                let meteors = try decoder.decode([MeteorModel].self, from: data)

                favorites = meteors

                onSuccess()
            } catch {
                onFailure("Unable save meteors to favorites \(error)")
            }
        }
    }
}
