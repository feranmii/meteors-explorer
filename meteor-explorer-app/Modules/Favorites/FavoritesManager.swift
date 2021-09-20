//
//  FavoritesManager.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation

/**
 Used for saving and retreiving favorites using the UserDefaults
 */
final class FavoritesManager {
    public var favourites: MeteorsListModel {
        get {
            if let data = UserDefaults.standard.data(forKey: "favourites") {
                do {
                    let decoder = JSONDecoder()

                    let meteors = try decoder.decode([MeteorModel].self, from: data)

                    return meteors

                } catch {
                    debugPrint("Unable to decode meteors \(error)")
                }
            }

            return []
        }
        set(val) {
            do {
                let encoder = JSONEncoder()

                let data = try encoder.encode(val)

                UserDefaults.standard.set(data, forKey: "favourites")
            } catch {
                debugPrint("Unable to decode meteors \(error)")
            }
        }
    }

    /**
     Check if a meteor has been added to favourites

     - parameter id: id of the meteor.
     - returns: Bool

     # Example #
     ```
     FavoritesManager.favouriteCheck(id: "ae920394")
     ```

     */
    public func favouriteCheck(id: String) -> Bool {
        return favourites.contains(where: {
            $0.id == id
        })
    }

    /**
     Add or remove a meteor from favourites

     - parameter model: model of the meteor.
     - parameter result: a callback which returns the favourite state of the meteor

     # Example #
     ```
     FavoritesManager.toggleFavourite(id: "ae920394") {result in

     })
     ```

     */
    public func toggleFavorites(_ model: MeteorModel?, _ result: (Bool) -> Void) {
        guard let meteor = model else {
            return
        }
        if favouriteCheck(id: meteor.id) {
            favourites.removeAll {
                $0.id == meteor.id
            }

            result(false)
        } else {
            favourites.append(meteor)
            result(true)
        }
    }
}
