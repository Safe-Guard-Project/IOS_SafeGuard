// UserEndPoint.swift

import Foundation

enum UserEndpoints {
    case signIn
    case signUp
    case displayUserProfile(userId: String)
    case recoverPasswordByEmail
    case recoverPasswordByPhone
    case changePassword
    case uploadImage
    var path: String {
        switch self {
        case .signIn:
            return "user/loginClient"
        case .signUp:
            return "user/registerClient"
        case .uploadImage:
            return "user/upload"
        case .displayUserProfile(let userId):
            return "user/profile/\(userId)"
        case .recoverPasswordByEmail:
            return "user/recoverPassword/"
        case .recoverPasswordByPhone:
            return "user/recoverPassBySms/"
        case .changePassword:
            return "user/changePass"

        }
    }

    var httpMethod: String {
        switch self {
        case .signIn, .signUp:
            return "POST"
        default:
            return "GET"
        }
    }
}
