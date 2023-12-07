    import Foundation
    import Combine
    import LocalAuthentication

    class SignInViewModel: ObservableObject {
        private let userRepository: UserRepository
        private var cancellables: Set<AnyCancellable> = []

        // Input properties
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var signInResult: Result<User?, Error>? = nil
        @Published var isSignedIn: Bool = false
        @Published var isSigningIn: Bool = false

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

        // Function to perform sign-in
        func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
            print("function is called")

            // Ensure that email and password are provided
            guard !email.isEmpty, !password.isEmpty else {
                print("Email and password cannot be empty")
                completion(.failure(NetworkError.invalidData))
                return
            }

            // Create a Login object with the provided parameters
            let login = Login(email: email, password: password)
            print("Email: \(email)")
            print("Password: \(password)")

            // Call the signIn function in the repository
            userRepository.signIn(user: login)
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
                    print("Sign in response: \(String(describing: response))")

                    // Check if the response contains user information
                    if let user = response {
                        // Save user information to UserDefaults
                        completion(.success(user))

                        // Update the state to indicate successful sign-in
                        self.isSignedIn = true
                    }
                })
                .store(in: &cancellables)
        }
        
        
        
        
        
        func authenticateWithFaceID(completion: @escaping (Result<User, Error>) -> Void) {
                let context = LAContext()

                // Check if the device supports Face ID
                guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                    completion(.failure(NetworkError.biometricsNotAvailable))
                    return
                }

                let reason = "Authenticate with Face ID"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    DispatchQueue.main.async {
                        if success {
                            // Face ID authentication successful
                            // Call completion with the result of successful authentication
                            completion(.success(User.mockUser())) // Replace with your user object
                        } else {
                            // Face ID authentication failed
                            // Call completion with the result of failed authentication
                            completion(.failure(error ?? NetworkError.unknownError))
                        }
                    }
                }
            }
    }
