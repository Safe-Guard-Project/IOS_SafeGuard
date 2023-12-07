//This file represents the API service responsible for making network requests.
import Foundation
import Combine



protocol APIService {
    init()
    func signUp(user: User) -> AnyPublisher<User?, Error>
    func signIn(user: Login) -> AnyPublisher<User?, Error>
    func displayUserProfile(userId: String) -> AnyPublisher<User?, Error>
    func getCatastrophe() -> AnyPublisher<[Catastrophe]?, Error>
    func recoverPasswordByEmail(email: String) -> AnyPublisher<OtpResponse?, Error>
    func recoverPasswordByPhone(numeroTel: String) -> AnyPublisher<OtpCode?, Error>
    func changePassword(cPass:CPass) -> AnyPublisher<CPassRes?, Error>

}


