//
//  ZoneDeDanger.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 6/12/2023.
//
import Foundation
import CoreLocation

struct ZoneDeDanger: Codable, Identifiable, Hashable {
    let id: String
    let latitudeDeZoneDanger: Double
    let longitudeDeZoneDanger: Double
    let idUser: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case latitudeDeZoneDanger, longitudeDeZoneDanger, idUser, createdAt, updatedAt
    }


  

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        latitudeDeZoneDanger = try container.decode(Double.self, forKey: .latitudeDeZoneDanger)
        
        // Use the correct key for decoding longitude
        longitudeDeZoneDanger = try container.decode(Double.self, forKey: .longitudeDeZoneDanger)
        
        idUser = try container.decode(String.self, forKey: .idUser)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }

}
