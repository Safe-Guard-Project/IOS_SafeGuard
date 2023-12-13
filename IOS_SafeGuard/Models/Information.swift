/*import Foundation

struct Information: Identifiable, Codable {
    var id: String
    let titre: String
    let typeCatastrophe: String
    let idUser: String // Assuming idUser is a String in your Mongoose schema
    let pays: String
    let region: String
    let descriptionInformation: String
    let dateDePrevention: Date
    let image: String
    let pourcentageFiabilite: Double
    let etat: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case titre
        case typeCatastrophe
        case idUser
        case pays
        case region
        case descriptionInformation
        case dateDePrevention
        case image
        case pourcentageFiabilite
        case etat
    }

    /*init(titre: String, typeCatastrophe: String, idUser: String, pays: String, region: String, descriptionInformation: String, dateDePrevention: Date, image: String?, pourcentageFiabilite: Double, etat: String) {
        self.id = UUID().uuidString
        self.titre = titre
        self.typeCatastrophe = typeCatastrophe
        self.idUser = idUser
        self.pays = pays
        self.region = region
        self.descriptionInformation = descriptionInformation
        self.dateDePrevention = dateDePrevention
        self.image = image
        self.pourcentageFiabilite = pourcentageFiabilite
        self.etat = etat
    }*/

    /*init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(String.self, forKey: .id)
        titre = try container.decode(String.self, forKey: .titre)
        typeCatastrophe = try container.decode(String.self, forKey: .typeCatastrophe)
        idUser = try container.decode(String.self, forKey: .idUser)
        pays = try container.decode(String.self, forKey: .pays)
        region = try container.decode(String.self, forKey: .region)
        descriptionInformation = try container.decode(String.self, forKey: .descriptionInformation)
        dateDePrevention = try container.decode(Date.self, forKey: .dateDePrevention)
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? "" // Use a default value or handle nil as needed
        pourcentageFiabilite = try container.decode(Double.self, forKey: .pourcentageFiabilite)
        etat = try container.decode(String.self, forKey: .etat)
    }*/}
*/
/*import SwiftUI

struct Information: Identifiable, Decodable {
    var id: String?
    var titre: String? // Make this optional
    var typeCatastrophe: String
    var pays: String
    var region: String
    var descriptionInformation: String
    var dateDePrevention: Date
    var image: String?
    var pourcentageFiabilite: Int
    var etat: String
    var createdAt: Date
    var updatedAt: Date
    var __v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case titre, typeCatastrophe, pays, region, descriptionInformation, dateDePrevention, image, pourcentageFiabilite, etat, createdAt, updatedAt, __v
    }
}
*/
