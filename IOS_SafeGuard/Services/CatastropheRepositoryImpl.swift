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
                catastrophes?.map { apiCatastrophe in
                    return Catastrophe(
                        _id: apiCatastrophe._id,
                        titre: apiCatastrophe.titre,
                        type: apiCatastrophe.type,
                        tsunami: apiCatastrophe.tsunami,
                        description: apiCatastrophe.description,
                        date: apiCatastrophe.date,
                        radius: apiCatastrophe.radius,
                        magnitude: apiCatastrophe.magnitude,
                        latitudeDeCatastrophe: apiCatastrophe.latitudeDeCatastrophe,
                        longitudeDeCatastrophe: apiCatastrophe.longitudeDeCatastrophe,
                        createdAt: apiCatastrophe.createdAt,
                        updatedAt: apiCatastrophe.updatedAt
                    )
                } ?? []
            }
            .eraseToAnyPublisher()
    }
}

