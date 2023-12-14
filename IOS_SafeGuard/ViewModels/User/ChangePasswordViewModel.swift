    //
    //  ChangePassword.swift
    //  IOS_SafeGuard
    //
    //  Created by Omar.Djebbi on 3/12/2023.
    //

    import Foundation
    import Combine

class ChangePasswordViewModel: ObservableObject {
    private let userRepository: UserRepository
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var changePasswordResult: Result<CPassRes?, Error>?
    
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


            
    
            
            func changePassword(newPassword: String, confirmPassword: String, completion: @escaping (Result<CPassRes?, Error>) -> Void) {
                // Ensure that email and password are provided
                guard !newPassword.isEmpty, !confirmPassword.isEmpty else {
                    print("New Password and Confirm Password cannot be empty")
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                
                // Create a CPass object with the provided parameters
                let cPass = CPass(newPassword: newPassword, confirmPassword: confirmPassword)
                
                userRepository.changePassword(cPass: cPass)
                    .sink { [weak self] completion in
                        guard let self = self else { return }
                        
                        switch completion {
                        case .finished:
                            break // Do nothing on success, as the data is optional
                        case .failure(let error):
                            // Handle error
                            self.changePasswordResult = .failure(error)
                        }
                    } receiveValue: { response in
                        // Handle success or failure based on the response.message
                        if let message = response?.message {
                            // Handle success or failure based on the message
                            if message.lowercased() == "success" {
                                self.changePasswordResult = .success(response)
                            } else {
                                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
                                self.changePasswordResult = .failure(error)
                            }
                        } else {
                            // Handle nil response
                            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Change password response is nil"])
                            self.changePasswordResult = .failure(error)
                        }
                        completion(self.changePasswordResult!)
                    }
                    .store(in: &cancellables)
            }
        }
        
    
