//
//  Catastrophe.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 29/11/2023.
//
import Foundation
import MapKit

enum CatastropheType: String, Codable {
    case earthquake
    case tsunami
}

struct Catastrophe: Codable, Hashable  {

    
    let _id: String
    let titre: String
    let type: CatastropheType
    let description: String
    let date: Date
    let radius: Double
    let magnitude: Double
    let latitudeDeCatastrophe: Double
    let longitudeDeCatastrophe: Double

}
