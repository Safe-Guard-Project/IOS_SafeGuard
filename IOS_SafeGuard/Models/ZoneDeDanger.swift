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
    let latitudeDeZoneDeDanger: Double
    let longitudeDeZoneDeDanger: Double
    let idUser: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case latitudeDeZoneDeDanger, longitudeDeZoneDeDanger, idUser, createdAt, updatedAt
    }


    var location: CLLocationCoordinate2D {
         return CLLocationCoordinate2D(latitude: latitudeDeZoneDeDanger, longitude: longitudeDeZoneDeDanger)
     }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        latitudeDeZoneDeDanger = try container.decode(Double.self, forKey: .latitudeDeZoneDeDanger)
        
        // Use the correct key for decoding longitude
        longitudeDeZoneDeDanger = try container.decode(Double.self, forKey: .longitudeDeZoneDeDanger)
        
        idUser = try container.decode(String.self, forKey: .idUser)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }

}
