import Foundation
import Combine

class RecEmailViewModel: ObservableObject {
    private let userRepository: UserRepository
    private var cancellables: Set<AnyCancellable> = []

    // Input properties
    @Published var email: String = ""
    @Published var ForgotPasswordResult: Result<OtpResponse, Error>? = nil
    @Published var isForgetPasswordOn: Bool = false

    @Published var userId: String?

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

    // Function to perform password recovery by email
    func ForgetPasswordByEmail(email: String, completion: @escaping (Result<OtpResponse, Error>) -> Void) {
        // Ensure that email is provided
        guard !email.isEmpty else {
            print("Email cannot be empty")
            completion(.failure(NetworkError.invalidData))
            return
        }

        // Create an EmailRec object with the provided email
        let emailRec = EmailRec(email: email)
        print("Email: \(email)")

        // Call the recoverPasswordByEmail function in the repository
        userRepository.recoverPasswordByEmail(email: emailRec.email)
            .receive(on: DispatchQueue.main) // Ensure UI updates on the main thread
            .sink(receiveCompletion: { status in
                // Handle completion (success or failure)
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
                }
            }, receiveValue: { response in
                // Handle the response if needed
                print("Forget Password response: \(String(describing: response))")

                // Check if the response contains user information
                if let otpResponse = response {
                    // Save user information to UserDefaults
                    if let data = try? JSONEncoder().encode(otpResponse) {
                    } else {
                        // Handle encoding failure
                        completion(.failure(NetworkError.invalidData))
                        return
                    }

                    // Update the state to indicate that password recovery is in progress
                    self.isForgetPasswordOn = true
                    completion(.success(otpResponse))
                } else {
                    // Handle the case where the response is nil
                    completion(.failure(NetworkError.invalidResponse))
                }
            })
            .store(in: &cancellables)
    }

}
