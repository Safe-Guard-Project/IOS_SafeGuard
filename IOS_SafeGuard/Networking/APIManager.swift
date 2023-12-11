// ApiManager.swift
import Combine

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

    func getCatastrophes() -> AnyPublisher<[Catastrophe]?, Error> {
        let catastropheEndpoint = CatastropheEndpoint.getCatastrophes
        print("URL: \(NetworkConstants.baseURL + catastropheEndpoint.path)")
        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + catastropheEndpoint.path,
                                                        method: "GET",
                                                        params: nil,
                                                        queryParams: nil)
            .eraseToAnyPublisher()
    }
    
    func getZoneDeDangers() -> AnyPublisher<[ZoneDeDanger]?, Error> {
        let zoneDeDangerEndpoint = ZoneDeDangerEndpoint.getZoneDeDangers
        print("URL: \(NetworkConstants.baseURL + zoneDeDangerEndpoint.path)")
        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + zoneDeDangerEndpoint.path,
                                                        method: "GET",
                                                        params: nil,
                                                        queryParams: nil)
            .eraseToAnyPublisher()
    }

}
