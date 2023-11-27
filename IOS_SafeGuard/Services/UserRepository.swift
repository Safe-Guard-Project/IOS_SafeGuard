import Combine

protocol UserRepository {
    
    func signUp(user: User) -> AnyPublisher<User?, Error>
    // Add other methods as needed
}
