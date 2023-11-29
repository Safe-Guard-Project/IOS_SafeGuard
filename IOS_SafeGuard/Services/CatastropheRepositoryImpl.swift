//
//  CatastropheRepositoryImpl.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 29/11/2023.
//

// CatastropheRepository.swift
import Combine

protocol CatastropheRepository {
    func getCatastrophes() -> AnyPublisher<[Catastrophe]?, Error>
}

class CatastropheRepositoryImpl: CatastropheRepository {
    func getCatastrophes() -> AnyPublisher<[Catastrophe]?, Error> {
        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + CatastropheEndpoints.getCatastrophe.path,
                                                        method: CatastropheEndpoints.getCatastrophe.httpMethod,
                                                        params: nil)
    }
}
