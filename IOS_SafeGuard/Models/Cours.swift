//import Foundation
/*
struct Cours: Codable, Identifiable {
    let id : String
    let type: CoursType
    let image: String
    let description: String
    
    enum CoursType: String, Codable {
        case Introduction = "Introduction"
        case CAUSE = "CAUSE"
        case CONSEQUENCE = "CONSEQUENCE"
        case SIGNE = "SIGNE"
        case Agir = "Agir"
    }
    
    /* enum CodingKeys: String, CodingKey {
         case id = "_id"
         case image = "image"
         case Titre = "Titre"
         case descriptionProgramme = "descriptionProgramme"
         case cours = "cours"
     }
     */
}
*/
/*
import Foundation
import SwiftUI
import CoreData

struct Cours: Identifiable, Codable {
    let id : UUID?
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
    init(type: CoursType, image: String, description: String) {
        self.type = Type
        self.image = image
        self.description = description

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(UUID.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        description = try container.decode(String.self, forKey: .description)

       
    }
}
*/
/*
import Foundation
import SwiftUI
import CoreData

struct Cours: Identifiable, Codable {
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

    init(id: String, type: CoursType, image: String, description: String) {
        self.id = "_id"
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

    // If you have an encoder, you might want to implement it as well.
    // func encode(to encoder: Encoder) throws { ... }
}

*/
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

    /*func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(Nom_Article, forKey: .Nom_Article)
        try container.encode(Nom_Client, forKey: .Nom_Client)
        try container.encode(address_mail_Client, forKey: .address_mail_Client)
        try container.encode(numero_Client, forKey: .numero_Client)
        try container.encode(ville, forKey: .ville)
        try container.encode(address_Client, forKey: .address_Client)
    }
}*/
