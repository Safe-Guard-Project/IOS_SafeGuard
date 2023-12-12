import Foundation
import SwiftUI
import CoreData

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

        if let coursArray = try? container.decode([String].self, forKey: .cours) {
            cours = coursArray
        } else {
            cours = []
        }
    }
}
/*

struct Program: Identifiable, Codable {
    var id: UUID?
    let imageName: String // Stocke le nom de l'image au lieu de l'URL complète
    let Titre: String
    let descriptionProgramme: String
    let cours: [String]

    init(imageName: String, Titre: String, descriptionProgramme: String, cours: [String]) {
        self.imageName = imageName
        self.Titre = Titre
        self.descriptionProgramme = descriptionProgramme
        self.cours = cours
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(UUID.self, forKey: .id)
        imageName = try container.decode(String.self, forKey: .imageName) // Utilise le nom de l'image ici
        Titre = try container.decode(String.self, forKey: .Titre)
        descriptionProgramme = try container.decode(String.self, forKey: .descriptionProgramme)

        if let coursArray = try? container.decode([String].self, forKey: .cours) {
            cours = coursArray
        } else {
            cours = []
        }
    }

    // Ajoute une propriété calculée pour générer dynamiquement l'URL de l'image
    var imageURL: URL? {
        return URL(string: "https://res.cloudinary.com/dtjsc8w0t/image/upload/\(imageName)")
    }
}
*/
