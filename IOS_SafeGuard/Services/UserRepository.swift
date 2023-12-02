import Combine

protocol UserRepository {
    init(apiService: APIService, webServiceProvider: WebServiceProvider)
    func signUp(user: User) -> AnyPublisher<User?, Error>
    func signIn(user:Login)->AnyPublisher<User?,Error>
    func getUserInformation(userId: String) -> AnyPublisher<User?, Error>
    func recoverPasswordByEmail(email: String) -> AnyPublisher<String?, Error>
      func recoverPasswordByPhone(numeroTel: String) -> AnyPublisher<String?, Error>
    }
