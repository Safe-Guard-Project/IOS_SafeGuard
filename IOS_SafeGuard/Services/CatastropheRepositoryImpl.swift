//
//  CatastropheRepositoryImpl.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 1/12/2023.
//


import Combine
import Foundation

class CatastropheRepositoryImpl: CatastropheRepository {
    
    
    private let apiService: APIService
    private let webServiceProvider: WebServiceProvider
    
    init(apiService: APIService, webServiceProvider: WebServiceProvider) {
        self.apiService = apiService
        self.webServiceProvider = webServiceProvider
    }
    
    func getCatastrophes() -> AnyPublisher<[Catastrophe], Error> {
        let endpoint = CatastropheEndpoint.getCatastrophe
                let request = APIRequest(method: .get, endpoint: endpoint)
                return apiService.performRequest(request)
                    .map(\.data)
                    .decode(type: [Catastrophe].self, decoder: webServiceProvider.jsonDecoder)
                    .eraseToAnyPublisher()
        <#code#>
    }
}
