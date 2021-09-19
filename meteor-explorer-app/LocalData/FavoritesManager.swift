//
//  SessionManager.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation

/**
 Used for saving and retreiving local data using the UserDefaults
 */
struct FavoritesManager {
    // An array of meteor objects used to save favourited meteors
    static var favourites: MeteorsListModel {
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
     SessionManager.favouriteCheck(id: "ae920394")
     ```

     */
    static func favouriteCheck(id: String) -> Bool {
        return favourites.contains(where: {
            $0.id == id
        })
    }

    /**
     Add or remove a meteor from favourites

     - parameter id: id of the meteor.
     - parameter result: a callback which returns the favourite state of the meteor

     # Example #
     ```
     SessionManager.toggleFavourite(id: "ae920394", isFavourite: {result in

     })
     ```

     */
    static func toggleFavorites(_ model: MeteorModel?, _ result: (Bool) -> Void) {
        guard let meteor = model else {
            return
        }
        if FavoritesManager.favouriteCheck(id: meteor.id) {
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
