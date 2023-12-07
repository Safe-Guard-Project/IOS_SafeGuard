import Combine
import Foundation

class ApiManager: APIService {
    static let shared = ApiManager()

    required internal init() {}

    func signUp(user: User) -> AnyPublisher<User?, Error> {
        let signUpEndpoint = UserEndpoints.signUp.path.description
        print("URL: \(NetworkConstants.baseURL + signUpEndpoint)")

        let params: [String: Any] = [
            "UserName": user.UserName,
            "email": user.email,
            "password": user.password,
            "numeroTel": user.numeroTel,
        ]
        print("Params: \(params)")

        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + signUpEndpoint,
                                                        method: "POST",
                                                        params: params)
            .eraseToAnyPublisher()
    }

    func signIn(user: Login) -> AnyPublisher<User?, Error> {
        let signInEndpoint = UserEndpoints.signIn.path.description
        print("URL: \(NetworkConstants.baseURL + signInEndpoint)")

        let params: [String: Any] = [
            "email": user.email,
            "password": user.password
        ]
        print("Params: \(params)")

        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + signInEndpoint,
                                                        method: "POST",
                                                        params: params)
            .eraseToAnyPublisher()
    }

    func displayUserProfile(userId: String) -> AnyPublisher<User?, Error> {
        let userProfileEndpoint = UserEndpoints.displayUserProfile(userId: userId).path
        print("URL: \(NetworkConstants.baseURL + userProfileEndpoint)")

        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + userProfileEndpoint,
                                                        method: "GET",
                                                        params: nil,
                                                        queryParams: nil)
            .eraseToAnyPublisher()
    }

    func getCatastrophe() -> AnyPublisher<[Catastrophe]?, Error> {
        let catastropheEndpoint = CatastropheEndpoint.getCatastrophe
        print("URL: \(NetworkConstants.baseURL + catastropheEndpoint.path)")
        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + catastropheEndpoint.path,
                                                        method: "GET",
                                                        params: nil,
                                                        queryParams: nil)
            .eraseToAnyPublisher()
    }
    func recoverPasswordByEmail(email: String) -> AnyPublisher<OtpResponse?, Error> {
            let recoverPasswordEndpoint = UserEndpoints.recoverPasswordByEmail.path
            print("URL: \(NetworkConstants.baseURL + recoverPasswordEndpoint)")

            let params: [String: Any] = [
                "email": email
            ]
            print("Params: \(params)")

            return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + recoverPasswordEndpoint,
                                                            method: "POST",
                                                            params: params)
                .map { resetCode in
                    // You can add additional handling or transformation here if needed
                    return resetCode
                }
                .eraseToAnyPublisher()
        }
    func recoverPasswordByPhone(numeroTel: String) -> AnyPublisher<OtpCode?, Error> {
            let recoverPasswordEndpoint = UserEndpoints.recoverPasswordByPhone.path
            print("URL: \(NetworkConstants.baseURL + recoverPasswordEndpoint)")

            let params: [String: Any] = [
                "numeroTel": numeroTel
            ]
            print("Params: \(params)")

            return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + recoverPasswordEndpoint,
                                                            method: "POST",
                                                            params: params)
                .map { resetCode in
                    // You can add additional handling or transformation here if needed
                    return resetCode
                }
                .eraseToAnyPublisher()
        }
    func changePassword(cPass:CPass )-> AnyPublisher<CPassRes?, Error> {
           let changePasswordEndpoint = UserEndpoints.changePassword.path.description
           let params: [String: Any] = [
            "password": cPass.newPassword,
            "confirmPassword": cPass.confirmPassword
           ]

        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + changePasswordEndpoint,
               method: "POST",
               params: params
           )
           .eraseToAnyPublisher()
       }
}
