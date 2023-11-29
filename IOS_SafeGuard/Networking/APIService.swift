//This file represents the API service responsible for making network requests.
import Foundation
import Combine



protocol APIService {

    func signUp(user: User) -> AnyPublisher<User?, Error>
    func getCatastrophes() -> AnyPublisher<[Catastrophe]?, Error>
}


