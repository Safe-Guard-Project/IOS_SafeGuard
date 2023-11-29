import Combine
import Foundation
import CoreData
class UserRepositoryImpl: UserRepository {
    private let apiService: APIService
    private let webServiceProvider: WebServiceProvider
    


    init(apiService: APIService , webServiceProvider: WebServiceProvider) {
        self.apiService = apiService
        self.webServiceProvider = webServiceProvider

    }

    func signUp(user: User) -> AnyPublisher<User?, Error> {
        let signUpEndpoint = UserEndpoints.signUp.path.description // Convert enum to String
        let params: [String: Any] = [
            "UserName": user.UserName,
            "email": user.email,
            "password": user.password,
            "numeroTel": user.numeroTel,
        ]

        return webServiceProvider.callWebService(
            url: NetworkConstants.baseURL + signUpEndpoint,
            method: "POST",
            params: params
        )
        .map { (user: User?) -> User? in
            // Save user information after successful sign-up
            if let user = user {
            }
            return user
        }
        .eraseToAnyPublisher()
    }

    func signIn(user: Login) -> AnyPublisher<User?, Error> {
        let signInEndpoint = UserEndpoints.signIn.path.description
        let params: [String: Any] = [
            "email": user.email,
            "password": user.password
        ]

        return webServiceProvider.callWebService(
            url: NetworkConstants.baseURL + signInEndpoint,
            method: "POST",
            params: params
        )
        .map { (user: User?) -> User? in
            // Save user information after successful sign-in
            if let user = user {
            }
            return user
        }
        .eraseToAnyPublisher()
    }

    func displayUserProfile(userId: String) -> AnyPublisher<User?, Error> {
            let displayUserProfileEndpoint = UserEndpoints.displayUserProfile(userId: userId).path.description

            return webServiceProvider.callWebService(
                url: NetworkConstants.baseURL + displayUserProfileEndpoint,
                method: "GET",
                params: [:]
            )
            .eraseToAnyPublisher()
        }
  


}
