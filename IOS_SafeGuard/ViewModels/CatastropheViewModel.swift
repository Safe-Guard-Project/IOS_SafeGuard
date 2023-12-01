import Foundation
import Combine

class CatastropheViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let repository: CatastropheRepository

    @Published var catastrophes: [Catastrophe] = []

    init(repository: CatastropheRepository = CatastropheRepositoryImpl()) {
        self.repository = repository
    }

    func getCatastrophes() {
        repository.getCatastrophes()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break // Do nothing on success
                case .failure(let error):
                    print("Error fetching catastrophes: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] fetchedCatastrophes in
                guard let self = self else { return }
                self.catastrophes = fetchedCatastrophes
            }
            .store(in: &cancellables)
    }
}


