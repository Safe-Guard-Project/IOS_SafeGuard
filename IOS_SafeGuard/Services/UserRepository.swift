import Combine
import Foundation

protocol UserRepository {
    init(apiService: APIService, webServiceProvider: WebServiceProvider)
    func signUp(user: User) -> AnyPublisher<User?, Error>
    func signIn(user:Login)->AnyPublisher<User?,Error>
    func getUserInformation(userId: String) -> AnyPublisher<User?, Error>
    func recoverPasswordByEmail(email: String) -> AnyPublisher<OtpResponse?, Error>
    func recoverPasswordByPhone(numeroTel: String) -> AnyPublisher<OtpCode?, Error>
    func changePassword(cPass:CPass) -> AnyPublisher<CPassRes?, Error>

    }
