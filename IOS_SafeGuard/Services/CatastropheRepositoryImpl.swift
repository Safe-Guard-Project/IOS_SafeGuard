//
//  CatastropheRepositoryImpl.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 29/11/2023.
//

// CatastropheRepository.swift
import Combine
import Foundation

class CatastropheRepositoryImpl: CatastropheRepository {
    private let apiManager: APIService
    
    init(apiManager: APIService = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
    func getCatastrophes() -> AnyPublisher<[Catastrophe], Error> {
        return apiManager.getCatastrophes()
            .map { catastrophes in
                catastrophes ?? []
            }
            .eraseToAnyPublisher()
    }
}
