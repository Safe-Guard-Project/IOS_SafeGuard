//
//  User.swift
//  IOS_SafeGuard
//
//  Created by Omar.Djebbi on 26/11/2023.
//When you declare a class or struct as Codable, you're essentially saying that instances of that type can be easily converted to and from a format like JSON

import Foundation
enum UserRole: String, Codable {
    case CLIENT
    case ADMIN
}

struct User: Codable {
    let _id: String
    let userName: String
    let email: String
    let password: String
    let role: UserRole
    let latitudeUser: Int
    let longitudeUser: Int
    let numeroTel: String
    let token: String
}

