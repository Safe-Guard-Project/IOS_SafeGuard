import Foundation
import MapKit

enum CatastropheType: String, Codable {
    case earthquake
    case tsunami
}

struct Catastrophe: Identifiable, Codable {
    var id: String  // Change the type to String, assuming _id is of String type
    
    var _id: String
    let titre: String
    let type: CatastropheType
    let description: String
    let date: Date
    let radius: Double
    let magnitude: Double
    let latitudeDeCatastrophe: Double
    let longitudeDeCatastrophe: Double

    enum CodingKeys: String, CodingKey {
        case _id = "id" // Adjust the key according to your API response
        case titre, type, description, date, radius, magnitude, latitudeDeCatastrophe, longitudeDeCatastrophe
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _id = try container.decode(String.self, forKey: ._id)
        titre = try container.decode(String.self, forKey: .titre)
        type = try container.decode(CatastropheType.self, forKey: .type)
        description = try container.decode(String.self, forKey: .description)

        let dateString = try container.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "your_date_format_here" // Adjust this date format according to your date format in the JSON
        if let date = dateFormatter.date(from: dateString) {
            self.date = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }

        radius = try container.decode(Double.self, forKey: .radius)
        magnitude = try container.decode(Double.self, forKey: .magnitude)
        latitudeDeCatastrophe = try container.decode(Double.self, forKey: .latitudeDeCatastrophe)
        longitudeDeCatastrophe = try container.decode(Double.self, forKey: .longitudeDeCatastrophe)
        
        // Assign _id to id
        id = _id
    }
}
