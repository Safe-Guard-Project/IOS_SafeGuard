// UserEndPoint.swift

import Foundation

enum UserEndpoints {
    case signIn
    case signUp
    case displayUserProfile(userId: String)
    case recoverUserByEmail(email: String)
    case recoverPasswordByEmail(email: String)
    case recoverPasswordByPhone(phoneNumber: String)

    var path: String {
        switch self {
        case .signIn:
            return "user/loginClient"
        case .signUp:
            return "user/registerClient"
        case .displayUserProfile(let userId):
            return "user/profile/\(userId)"
        case .recoverUserByEmail(let email):
            return "user/recoverId/\(email)"
        case .recoverPasswordByEmail(let email):
            return "user/recoverPassword/\(email)"
        case .recoverPasswordByPhone(let phoneNumber):
            return "user/recoverPassBySms/\(phoneNumber)"
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
