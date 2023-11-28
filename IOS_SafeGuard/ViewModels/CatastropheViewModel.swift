
import Foundation
import Combine

class CatastropheViewModel: ObservableObject {
    private var repository: CatastropheRepository
    private var cancellables: Set<AnyCancellable> = []

    @Published var catastrophes: [Catastrophe] = []
    @Published var isLoading: Bool = false

    init(repository: CatastropheRepository) {
        self.repository = repository
    }

    func getCatastrophes() {
        isLoading = true

        repository.getCatastrophes()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    // Handle error, e.g., show an alert
                    print("Error fetching catastrophes: \(error)")
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] catastrophes in
                self?.catastrophes = catastrophes
            }
            .store(in: &cancellables)
    }
}
