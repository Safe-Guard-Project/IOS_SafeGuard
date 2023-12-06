//
//  ZoneDeDangerRepository.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 6/12/2023.
//

import Foundation
import Combine

protocol ZoneDeDangerRepository {
    func getZoneDeDangers() -> AnyPublisher<[ZoneDeDanger], Error>
    
}
 
