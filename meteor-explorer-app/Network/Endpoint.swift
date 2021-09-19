//
//  Endpoint.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 19/09/2021.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = UrlConstants.baseUrl
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

extension Endpoint {
    static func getMeteorsByDate() -> Endpoint {
        return Endpoint(
            path: UrlConstants.meteorsUrl,
            queryItems: [
                URLQueryItem(name: "$where", value: "year >= '1900-01-10T12:00:00'")
            ]
        )
    }

    static func getMeteorsBySize() -> Endpoint {
        return Endpoint(
            path: UrlConstants.meteorsUrl,
            queryItems: [
                URLQueryItem(name: "$order", value: "mass"),
                URLQueryItem(name: "$where", value: "mass > 1000")
            ]
        )
    }
}
