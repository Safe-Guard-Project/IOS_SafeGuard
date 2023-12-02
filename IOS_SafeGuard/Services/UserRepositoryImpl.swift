import Combine
import Foundation
import CoreData
class UserRepositoryImpl: UserRepository {
    private let apiService: APIService
    private let webServiceProvider: WebServiceProvider

    required init(apiService: APIService, webServiceProvider: WebServiceProvider) {
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
        .tryMap { (user: User?) -> User in
            // Handle success or throw an error
            guard let user = user else {
                throw NetworkError.invalidResponse
            }
            // Save user information after successful sign-in
            return user
        }
        .eraseToAnyPublisher()
    }


    func getUserInformation(userId: String) -> AnyPublisher<User?, Error> {
        // Retrieve the _id from UserDefaults
        guard let storedUserId = UserDefaults.standard.string(forKey: "UserID") else {
            return Fail(error: NetworkError.invalidData).eraseToAnyPublisher()
        }
        
        // Use the retrieved _id
        let getUserInformationEndpoint = UserEndpoints.displayUserProfile(userId: storedUserId).path.description
        
        return webServiceProvider.callWebService(
            url: NetworkConstants.baseURL + getUserInformationEndpoint,
            method: "GET",
            params: [:]
        )
        .eraseToAnyPublisher()
    }
    func recoverPasswordByEmail(email: String) -> AnyPublisher<String?, Error> {
            let endpoint = UserEndpoints.recoverPasswordByEmail
            let params: [String: Any] = ["email": email]

            return webServiceProvider.callWebService(
                url: NetworkConstants.baseURL + endpoint.path,
                method: "POST",
                params: params
            )
            .flatMap { (data: Data?) -> Result<String?, Error>.Publisher in
                guard let data = data else {
                    return Result.Publisher(.failure(NetworkError.invalidResponse))
                }

                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode([String: String].self, from: data)
                    let resetCode = response["resetCode"]
                    return Result.Publisher(.success(resetCode))
                } catch {
                    return Result.Publisher(.failure(NetworkError.invalidResponse))
                }
            }
            .eraseToAnyPublisher()
        }

    func recoverPasswordByPhone(numeroTel: String) -> AnyPublisher<String?, Error> {
            let endpoint = UserEndpoints.recoverPasswordByPhone
            let params: [String: Any] = ["numeroTel": numeroTel]

            return webServiceProvider.callWebService(
                url: NetworkConstants.baseURL + endpoint.path,
                method: "POST",
                params: params
            )
            .flatMap { (data: Data?) -> Result<String?, Error>.Publisher in
                guard let data = data else {
                    return Result.Publisher(.failure(NetworkError.invalidResponse))
                }

                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode([String: String].self, from: data)
                    let resetCode = response["otpCode"]
                    return Result.Publisher(.success(resetCode))
                } catch {
                    return Result.Publisher(.failure(NetworkError.invalidResponse))
                }
            }
            .eraseToAnyPublisher()
        }
 
  


}
