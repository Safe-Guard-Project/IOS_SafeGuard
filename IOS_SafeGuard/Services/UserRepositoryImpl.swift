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
    func recoverPasswordByEmail(email: String) -> AnyPublisher<OtpResponse?, Error> {
        let RecoverPassEndpoint = UserEndpoints.recoverPasswordByEmail.path.description
        let params: [String: Any] = ["email": email]
        
        return webServiceProvider.callWebService(
            url: NetworkConstants.baseURL + RecoverPassEndpoint,
            method: "POST",
            params: params
        )
        .tryMap { (otpResponse: OtpResponse?) -> OtpResponse in
            // Handle success or throw an error
            guard let resetCode = otpResponse  else {
                throw NetworkError.invalidResponse
            }
            // Save user information after successful sign-in
            return resetCode
        }
        .eraseToAnyPublisher()
    }
    func recoverPasswordByPhone(numeroTel: String) -> AnyPublisher<OtpCode?, Error> {
        let RecoverPassEndpoint = UserEndpoints.recoverPasswordByPhone.path.description
        let params: [String: Any] = ["numeroTel": numeroTel]
        
        return webServiceProvider.callWebService(
            url: NetworkConstants.baseURL + RecoverPassEndpoint,
            method: "POST",
            params: params
        )
        .tryMap { (otpResponse: OtpCode?) -> OtpCode in
            // Handle success or throw an error
            guard let otpCode = otpResponse else {
                throw NetworkError.invalidResponse
            }
            // Save user information after successful sign-in
            return otpCode
        }
        .eraseToAnyPublisher()
    }

    
    func changePassword(cPass:CPass) -> AnyPublisher<CPassRes?, Error> {
        let changePasswordEndpoint = UserEndpoints.changePassword.path.description
        let params: [String: Any] = [
            "password": cPass.newPassword,
            "confirmPassword": cPass.confirmPassword
        ]

        return webServiceProvider.callWebService(
            url: NetworkConstants.baseURL + changePasswordEndpoint,
            method: "POST",
            params: params
        )
        .tryMap { (response: CPassRes?) -> CPassRes? in
            // Check the response for custom validation
            guard let response = response else {
                // If the response is nil, throw a custom error
                throw NetworkError.invalidResponse
            }

            // Perform additional validation if needed

            // Return the response if everything is valid
            return response
        }
        .eraseToAnyPublisher()
    }

}
