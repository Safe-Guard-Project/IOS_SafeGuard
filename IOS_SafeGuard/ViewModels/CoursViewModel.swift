import Foundation
import Combine

class CoursViewModel: ObservableObject {
    @Published var courses: [Cours] = []
    private var cancellables: Set<AnyCancellable> = []

    func fetchCoursesByType(type: Cours.CoursType) {
        guard let url = URL(string: "http://localhost:9090/cours/\(type.rawValue)") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Cours].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // zedtha bch k naamil modification f design may9ala9nich
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] courses in
                self?.courses = courses
            }
            .store(in: &cancellables)
    }
}
