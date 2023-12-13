import Foundation
import Combine

class CoursViewModel: ObservableObject {
    @Published var courses: [Cours] = []
    private var cancellables: Set<AnyCancellable> = []

    func fetchCoursesByType(type: Cours.CoursType, program: Program) {
            guard let url = URL(string: "http://localhost:9090/cours/\(type.rawValue)") else {
                return
            }

            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: [Cours].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                } receiveValue: { [weak self] courses in
                    // Filtrer les cours par id du programme
                    let filteredCourses = courses.filter { course in
                        program.cours.contains { programCourse in
                            return course.id == programCourse.id
                        }
                    }

                    self?.courses = filteredCourses
                }
                .store(in: &cancellables)
        }

 
}
