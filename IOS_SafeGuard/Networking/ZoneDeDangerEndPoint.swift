//
//  ZoneDeDangerEndPoint.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 6/12/2023.
//

enum ZoneDeDangerEndpoint {
    case getZoneDeDangers
    case path

    var path: String {
        switch self {
        case .getZoneDeDangers:
            return "zoneDeDanger/" // Adjust the actual path accordingly
        case .path:
            return "zoneDeDanger/" // Adjust the actual path accordingly
        }
    }

    var httpMethod: String {
        switch self {
        case .getZoneDeDangers:
            return "GET"
        case .path:
            return "GET" // or another default value for .path
        }
    }
}
