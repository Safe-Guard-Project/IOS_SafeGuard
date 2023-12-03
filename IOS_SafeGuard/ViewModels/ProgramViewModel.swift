//
//  ProgramViewModel.swift
//  IOS_SafeGuard
//
//  Created by abir on 1/12/2023.
//

import Foundation
/*

class ProgramViewModel: ObservableObject {
    @Published var programs: [Program] = []

    func getPrograms() {
        guard let url = URL(string: "http://localhost:9090/programme/cours") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let programs = try JSONDecoder().decode([Program].self, from: data)
                    DispatchQueue.main.async {
                        self.programs = programs
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
 */
import Combine // Add this line to import Combine

class ProgramViewModel: ObservableObject {
    @Published var programs: [Program] = []

    private var cancellables: Set<AnyCancellable> = [] // This line should now be recognized

    func getAllPrograms() {
        guard let url = URL(string: "http://localhost:9090/programme/cours") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Program].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] programs in
                self?.programs = programs
            }
            .store(in: &cancellables)
    }
}
