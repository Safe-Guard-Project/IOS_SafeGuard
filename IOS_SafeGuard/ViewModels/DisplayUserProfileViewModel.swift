import Foundation
import Combine

class DisplayUserProfileViewModel: ObservableObject {
    @Published var userId: String = ""
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var userPhoneNumber: String = ""

    private var cancellables: Set<AnyCancellable> = []

    init(userId: String) {
        fetchUserInformation(userId: userId)
    }

    func fetchUserInformation(userId: String) {
        print("Fetching user information for userID: \(userId)...")
        
        let apiService: APIService = ApiManager.shared
        let webServiceProvider: WebServiceProvider = WebServiceProvider.shared

        let userRepository: UserRepository = UserRepositoryImpl(apiService: apiService, webServiceProvider: webServiceProvider)

        userRepository.displayUserProfile(userId: userId)
            .sink(receiveCompletion: { completion in
                // Handle completion if needed
            }, receiveValue: { user in
                if let user = user {
                    self.userId = user._id
                    self.userName = user.UserName
                    self.userEmail = user.email
                    self.userPhoneNumber = user.numeroTel

                    // Print or log the fetched data for debugging
                    print("User ID: \(self.userId), UserName: \(self.userName), Email: \(self.userEmail), PhoneNumber: \(self.userPhoneNumber)")
                }
            })
            .store(in: &cancellables)
    }
}
