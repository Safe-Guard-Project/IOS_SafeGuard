import Foundation

enum UserRole: String, Codable {
    case client
    case admin
}

struct User: Codable, Identifiable {
    let _id: String
    let UserName: String?
    let email: String?
    let password: String?
    let Role: UserRole?
    let latitudeUser: Int?
    let longitudeUser: Int?
    let numeroTel: String?

    // Include CodingKeys enum to handle custom key mappings
    enum CodingKeys: String, CodingKey {
        case _id
        case UserName
        case email
        case password
        case Role
        case latitudeUser
        case longitudeUser
        case numeroTel
    }

    var id: String {
        return _id
    }
    
    
}
extension User {
    static func mockUser() -> User {
        return User(_id: "mockID", UserName: "omardjo",email: "mr.djebbi@gmail.com",password:"test",Role:UserRole.client,latitudeUser:0,longitudeUser:0, numeroTel: "123456789")
        // Adjust the properties according to your actual User structure
    }
}


