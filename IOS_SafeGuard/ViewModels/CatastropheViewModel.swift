import Combine
import Foundation
import CoreLocation

class CatastropheViewModel: ObservableObject {
    @Published var catastrophes: [Catastrophe] = []
    private var cancellables: Set<AnyCancellable> = []

    private let apiManager: ApiManager

    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }

    func fetchCatastrophes() {
        apiManager.getCatastrophe()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Do nothing on success
                case .failure(let error):
                    // Handle the error (e.g., show an alert, log, etc.)
                    print("Error fetching catastrophes: (error.localizedDescription)")
                }
            }, receiveValue: { [weak self] catastrophes in
                self?.catastrophes = catastrophes ?? []
            })
            .store(in: &cancellables)
    }

    // Define the userLocation property
    var userLocation: CLLocationCoordinate2D? {
        return .init(latitude: 36.901000, longitude: 10.190120)
    }
}
