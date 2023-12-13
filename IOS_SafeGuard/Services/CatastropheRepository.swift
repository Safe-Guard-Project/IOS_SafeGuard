//
//  CatastropheRepository.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import Foundation
import Combine

protocol CatastropheRepository {
    func getCatastrophes() -> AnyPublisher<[Catastrophe], Error>
}
 
