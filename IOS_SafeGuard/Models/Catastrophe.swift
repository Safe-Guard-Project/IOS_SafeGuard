//
//  Catastrophe.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import Foundation
struct Catastrophe: Codable, Identifiable {
    
    let _id: String
    let titre: String
    let type: String
    let tsunami: Int
    let description: String
    let date: Date
    let radius: Double
    let magnitude: Double
    let latitudeDeCatastrophe: Double
    let longitudeDeCatastrophe: Double
    let createdAt: Date
    let updatedAt: Date
    var id: String {
        return _id
    }
}
