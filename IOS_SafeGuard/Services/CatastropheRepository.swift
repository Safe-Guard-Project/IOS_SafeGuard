//
//  CatastropheRepositoryImpl.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 29/11/2023.
//

// CatastropheRepository.swift
import Combine

protocol CatastropheRepository {
    init(apiService: APIService, webServiceProvider: WebServiceProvider)

    func getCatastrophe() -> AnyPublisher<[Catastrophe]?, Error>
}



