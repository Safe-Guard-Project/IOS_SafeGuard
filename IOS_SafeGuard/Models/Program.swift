import Foundation
import SwiftUI
import CoreData
/*
struct Program: Identifiable, Codable {
    var id: UUID?
    let image: String
    let Titre: String
    let descriptionProgramme: String
   let cours : [String]
    
   /* enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image = "image"
        case Titre = "Titre"
        case descriptionProgramme = "descriptionProgramme"
        case cours = "cours"
    }*/

   init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decodeIfPresent(UUID.self, forKey: .id)
            Titre = try container.decode(String.self, forKey: .Titre)
            descriptionProgramme = try container.decode(String.self, forKey: .descriptionProgramme)
            image = try container.decode(String.self, forKey: .image)
            cours = try container.decode([String].self, forKey: .cours)
        }
  
}
*/
struct Program: Identifiable, Codable {
    var id: UUID?
    let image: String
    let Titre: String
    let descriptionProgramme: String
    let cours: [String]

    init(image: String, Titre: String, descriptionProgramme: String, cours: [String]) {
        self.image = image
        self.Titre = Titre
        self.descriptionProgramme = descriptionProgramme
        self.cours = cours
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(UUID.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
        Titre = try container.decode(String.self, forKey: .Titre)
        descriptionProgramme = try container.decode(String.self, forKey: .descriptionProgramme)

        // Try to decode "cours" as an array of strings, fallback to an empty array if it fails
        if let coursArray = try? container.decode([String].self, forKey: .cours) {
            cours = coursArray
        } else {
            cours = [] // Handle the case where "cours" is not an array of strings
        }
    }
}
