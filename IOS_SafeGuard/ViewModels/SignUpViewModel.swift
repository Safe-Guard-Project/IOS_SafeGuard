import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    private let userRepository: UserRepository

    // Input properties
    @Published var UserName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var signUpResult: Result<User?, Error>? = nil

    // Inject the repository dependency
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    // Convenience initializer for default repository
    convenience init() {
        let apiService: APIService = ApiManager.shared
        let webServiceProvider: WebServiceProvider = WebServiceProvider.shared
        let userRepository: UserRepository = UserRepositoryImpl(apiService: apiService, webServiceProvider: webServiceProvider)
        self.init(userRepository: userRepository)
    }

    // Function to perform sign-up
    func signUp() {
        // Ensure that the full name is provided
        guard !UserName.isEmpty else {
            print("User Name cannot be empty")
            signUpResult = .failure(NetworkError.invalidData)
            return
        }

        // Create a User object with the provided parameters
        let user = User(_id: "", UserName: UserName, email: email, password: password, Role: UserRole.client, latitudeUser: 0, longitudeUser: 0, numeroTel: phoneNumber)

        // Call the signUp function in the repository
        userRepository.signUp(user: user)
            .receive(on: DispatchQueue.main) // Ensure UI updates on the main thread
            .sink { completion in
                // Handle completion (success or failure)
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.signUpResult = .failure(error)
                }
            } receiveValue: { response in
                // Handle the response if needed
                print("Sign up response: \(String(describing: response))")
            }
            .store(in: &cancellables)
    }

    private var cancellables: Set<AnyCancellable> = []
}
