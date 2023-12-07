import Foundation
import Combine

class RecNumTelViewModel: ObservableObject {
    private let userRepository: UserRepository
    private var cancellables: Set<AnyCancellable> = []

    // Input properties
    @Published var numeroTel: String = ""
    @Published var ForgotPasswordResult: Result<OtpCode, Error>? = nil
    @Published var isForgetPasswordOn: Bool = false
    @Published var navigateToOtpValidation: Bool = false
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

    // Function to perform password recovery by phone number
    func ForgetPasswordByPhoneNumber(numeroTel: String, completion: @escaping (Result<OtpCode, Error>) -> Void) {
        // Ensure that phone number is provided
        guard !numeroTel.isEmpty else {
            print("Phone number cannot be empty")
            completion(.failure(NetworkError.invalidData))
            return
        }

        // Create a NumTelRec object with the provided phone number
        let numeroTelRec = NumTelRec(numeroTel: numeroTel)
        print("NumeroTelRec: \(numeroTelRec)")

        // Call the recoverPasswordByPhone function in the repository
        userRepository.recoverPasswordByPhone(numeroTel: numeroTelRec.numeroTel)
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
                if let otpCode = response {
                    // Save user information to UserDefaults
                    if let data = try? JSONEncoder().encode(otpCode) {
                        UserDefaults.standard.set(data, forKey: "otpCode")
                    } else {
                        // Handle encoding failure
                        completion(.failure(NetworkError.invalidData))
                        return
                    }

                    // Update the state to indicate that password recovery is in progress
                    self.isForgetPasswordOn = true
                    completion(.success(otpCode))
                } else {
                    // Handle the case where the response is nil
                    completion(.failure(NetworkError.invalidResponse))
                }
            })
            .store(in: &cancellables)
    }

}
