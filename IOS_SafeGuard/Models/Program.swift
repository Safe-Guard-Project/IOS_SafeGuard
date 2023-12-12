import Foundation
import SwiftUI
import CoreData

struct Program: Identifiable, Codable {
    var id: String
    let image: String
    let Titre: String
    let descriptionProgramme: String
    let cours: [String]
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case Titre = "Titre"
        case image
        case descriptionProgramme
        case cours

    }

    init(id : String ,image: String, Titre: String, descriptionProgramme: String, cours: [String]) {
        self.id = id
        self.image = image
        self.Titre = Titre
        self.descriptionProgramme = descriptionProgramme
        self.cours = cours
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
        Titre = try container.decode(String.self, forKey: .Titre)
        descriptionProgramme = try container.decode(String.self, forKey: .descriptionProgramme)

        if let coursArray = try? container.decode([String].self, forKey: .cours) {
            cours = coursArray
        } else {
            cours = []
        }
    }
}
