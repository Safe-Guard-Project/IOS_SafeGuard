// CoursViewModel.swift

import Foundation

/*
class CoursViewModel: ObservableObject {
    @Published var courses: [Cours] = []
   
    func getCoursByType(programmeId: String, coursType: CoursType) {
        // Replace this URL with your backend endpoint
        guard let url = URL(string: "http://localhost:9090/cours/\(programmeId)/\(coursType.rawValue)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle the response data here
            if let data = data {
                do {
                    let decodedCourses = try JSONDecoder().decode([Cours].self, from: data)
                    DispatchQueue.main.async {
                        self.courses = decodedCourses
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

*/
