import Combine

protocol UserRepository {
    
    func signUp(user: User) -> AnyPublisher<User?, Error>
    func signIn(user:Login)->AnyPublisher<User?,Error>
    func displayUserProfile(userId: String) -> AnyPublisher<User?, Error>

    }
