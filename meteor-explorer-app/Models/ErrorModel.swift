//
//  ErrorModel.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 19/09/2021.
//

import Foundation

struct APIErrorModel: Codable {
    let code: String
    let errorCode: String?
    let error: Bool?
    let message: String
    let data: APIErrorData?
}

struct APIErrorData: Codable {
    let id: String
}
