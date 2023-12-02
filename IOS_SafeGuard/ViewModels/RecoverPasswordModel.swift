import Combine

class RecoverPasswordModel: ObservableObject {
    private let userRepository: UserRepository
    @Published var response: Result<String?, Error>? // Expose the result
    private var cancellables: Set<AnyCancellable> = []
    @Published var resetCode: String?
    
    // Add a Published property to store errors
    @Published var error: Error?
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func recoverPasswordByEmail(email: String) {
           userRepository.recoverPasswordByEmail(email: email)
               .sink(receiveCompletion: { [weak self] completion in
                   guard let self = self else { return }
                   switch completion {
                   case .finished:
                       break // Do nothing for successful completion
                   case .failure(let error):
                       // Store the error
                       self.error = error
                   }
               }, receiveValue: { [weak self] resetCode in
                   // Handle the received reset code
                   self?.resetCode = resetCode
               })
               .store(in: &cancellables)
       }

       func recoverPasswordByPhone(numeroTel: String) {
           userRepository.recoverPasswordByPhone(numeroTel: numeroTel)
               .sink(receiveCompletion: { [weak self] completion in
                   guard let self = self else { return }
                   switch completion {
                   case .finished:
                       break // Do nothing for successful completion
                   case .failure(let error):
                       // Store the error
                       self.error = error
                   }
               }, receiveValue: { [weak self] resetCode in
                   // Handle the received reset code
                   self?.resetCode = resetCode
               })
               .store(in: &cancellables)
       }
}
