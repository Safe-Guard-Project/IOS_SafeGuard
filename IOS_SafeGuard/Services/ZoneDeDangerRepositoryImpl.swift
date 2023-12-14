//
//  ZoneDeDangerRepositoryImpl.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 6/12/2023.
//
import Combine
import Foundation

class ZoneDeDangerRepositoryImpl: ZoneDeDangerRepository {
    private let apiManager: APIService
    
    init(apiManager: APIService = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
    func getZoneDeDangers() -> AnyPublisher<[ZoneDeDanger], Error> {
        return apiManager.getZoneDeDangers()
            .map { zoneDeDangers in
                zoneDeDangers ?? []
            }
            .eraseToAnyPublisher()
    }
}
