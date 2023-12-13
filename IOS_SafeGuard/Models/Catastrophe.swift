//
//  Catastrophe.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//
import Foundation

struct Catastrophe: Codable, Identifiable {
    let id: String
    let titre: String
    let type: String
    let description: String
    let date: String
    let radius: Double
    let magnitude: Double
    let latitudeDeCatastrophe: Double
    let longitudeDeCatastrophe: Double
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case titre, type, description, date, radius, magnitude, latitudeDeCatastrophe, longitudeDeCatastrophe, createdAt, updatedAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        titre = try container.decode(String.self, forKey: .titre)
        type = try container.decode(String.self, forKey: .type)
        description = try container.decode(String.self, forKey: .description)
        date = try container.decode(String.self, forKey: .date) // Change the type to String
        radius = try container.decode(Double.self, forKey: .radius)
        magnitude = try container.decode(Double.self, forKey: .magnitude)
        latitudeDeCatastrophe = try container.decode(Double.self, forKey: .latitudeDeCatastrophe)
        longitudeDeCatastrophe = try container.decode(Double.self, forKey: .longitudeDeCatastrophe)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
}
