import Foundation

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

