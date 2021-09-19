//
//  APIClient.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation
enum HTTPError: Error {
    case invalidRequest(String)
}

final class APIClient {
    public func get<T: Codable>(_ model: T.Type, _ endpoint: Endpoint, completion: @escaping (Result<T, HTTPError>) -> Void) {
        guard let componentUrl = endpoint.url else {
            completion(.failure(.invalidRequest("Wrong URL")))
            return
        }

        let request = URLRequest(url: componentUrl)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidRequest("Unable to connect")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                completion(.failure(.invalidRequest("No data available")))
                return
            }
            
            if 200 ..< 300 ~= httpResponse.statusCode {
                if let result = try? JSONDecoder().decode(T.self, from: responseData) {
                    completion(.success(result))
                } else {
                    completion(.failure(.invalidRequest("Invalid JSON")))
                }
                
            } else if 400 ..< 500 ~= httpResponse.statusCode {
                let errorModel = try? JSONDecoder().decode(APIErrorModel.self, from: responseData)
                
                completion(.failure(.invalidRequest(errorModel?.message ?? "")))
                
                return
            } else {
                completion(.failure(.invalidRequest("Cannot connect to the server")))
            }
           
        }.resume()
    }
}
