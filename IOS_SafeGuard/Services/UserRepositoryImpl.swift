import Combine
import Foundation
struct VoidWSResponse: Codable {
    // Your implementation here, if needed
}

class UserRepositoryImpl: UserRepository {
    private let apiService: APIService
    private let webServiceProvider: WebServiceProvider

    init(apiService: APIService, webServiceProvider: WebServiceProvider) {
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
     
    }

    // Implement other methods as needed
}
