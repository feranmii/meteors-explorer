//
//  MeteorModel.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation

struct MeteorModel: Codable {
    let name, id: String
    let mass: String?
    let year: String?
    let geolocation: Geolocation?
}

struct Geolocation: Codable {
    let coordinates: [Double]
}

typealias MeteorsListModel = [MeteorModel]
