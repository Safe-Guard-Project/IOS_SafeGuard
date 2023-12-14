import Foundation
import Combine

class DisplayUserProfileViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var userPhoneNumber: String = ""
    private let userRepository: UserRepository
    private var cancellables: Set<AnyCancellable> = []
    @Published var userId: String = ""

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
    }
    
    convenience init() {
        let apiService: APIService = ApiManager.shared
        let webServiceProvider: WebServiceProvider = WebServiceProvider.shared
        let userRepository: UserRepository = UserRepositoryImpl(apiService: apiService, webServiceProvider: webServiceProvider)
        self.init(userRepository: userRepository)
    }

    func fetchUserInformation() {
        guard !userId.isEmpty else {
            // Handle the case where userId is empty or not available
            return
        }

        userRepository.getUserInformation(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Handle completion if needed
            } receiveValue: { user in
                if let user = user {
                    self.userName = user.UserName ?? "DefaultUserName"
                    self.userEmail = user.email ?? "DefaultEmail"
                    self.userPhoneNumber = user.numeroTel ?? "DefaultPhoneNumber"
                } else {
                    // Handle the case where user is nil
                }
            }
            .store(in: &cancellables)
    }
    
    func saveUserProfileImage(imageData: Data) {
        userRepository.saveUserProfileImage(imageData: imageData)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Handle completion if needed
            } receiveValue: { response in
                // Handle the image upload response if needed
                if let response = response {
                    print("Image upload response: \(response)")
                } else {
                    print("Image upload failed or response is nil.")
                }
            }
            .store(in: &cancellables)
    }


}
