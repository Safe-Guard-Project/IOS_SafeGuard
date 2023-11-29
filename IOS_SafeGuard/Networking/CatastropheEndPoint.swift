//
//  CatastropheEndPoint.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 29/11/2023.
//

import Foundation

enum CatastropheEndpoints {
    case getCatastrophe

    var path: String {
        switch self {
        case .getCatastrophe:
            return "catastrophe/"
        }
    }

    var httpMethod: String {
        switch self {
        case .getCatastrophe:
            return "GET"
        }
    }
}
