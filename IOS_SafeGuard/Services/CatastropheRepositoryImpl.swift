//
//  CatastropheRepositoryImpl.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 1/12/2023.
//


import Combine
import Foundation

class CatastropheRepositoryImpl: CatastropheRepository {
    private let apiManager: APIService
    
    init(apiManager: APIService = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
    func getCatastrophes() -> AnyPublisher<[Catastrophe], Error> {
        return apiManager.getCatastrophe()
            .map { catastrophes in
                catastrophes ?? []
            }
            .eraseToAnyPublisher()
    }
}
