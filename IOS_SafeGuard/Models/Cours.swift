//
//  Cours.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import Foundation

struct Cours: Codable, Identifiable {
    let id: String
    let type: CoursType
    let image: String
    let description: String
    enum CoursType: String, Codable, CaseIterable {
        case Introduction = "Introduction"
        case CAUSE = "CAUSE"
        case CONSEQUENCE = "CONSEQUENCE"
        case SIGNE = "SIGNE"
        case Agir = "Agir"
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type = "Type"
        case image
        case description

    }

    init(id: String = "",
         type: CoursType,
         image: String ,
         description: String
         ) {
        self.id = id
        self.type = type
        self.image = image
        self.description = description
    }
    
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(String.self, forKey: .id)
            type = try container.decode(CoursType.self, forKey: .type)
            image = try container.decode(String.self, forKey: .image)
            description = try container.decode(String.self, forKey: .description)
        }
        
    }
