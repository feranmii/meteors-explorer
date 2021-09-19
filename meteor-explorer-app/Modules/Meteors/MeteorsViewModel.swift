//
//  MeteorsViewModel.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation

final class MeteorsViewModel {
    let apiClient = APIClient()

    var meteors: MeteorsListModel = []
    var endpoint: Endpoint = .getMeteorsByDate()
}

extension MeteorsViewModel {
    func fetchMeteors(onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        apiClient.get(MeteorsListModel.self, endpoint, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let info):
                switch info {
                case .invalidRequest(let value):
                    onFailure(value)
                }
            case .success(let data):
                self.meteors = data
                onSuccess()
            }
        })
    }
}

enum MeteorFilterType {
    case date
    case size
}
