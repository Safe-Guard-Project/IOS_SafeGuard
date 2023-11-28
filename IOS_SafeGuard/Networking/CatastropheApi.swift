//
//  CatastropheApi.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import Foundation

protocol CatastropheApi {
    func getCatastrophes(completion: @escaping (Result<[Catastrophe], Error>) -> Void)
}
