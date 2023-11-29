//
//  CatastropheViewModel.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 29/11/2023.
//


import Combine

class CatastropheViewModel: ObservableObject {
    @Published var catastrophes: [Catastrophe] = []
    private var cancellables: Set<AnyCancellable> = []

    func fetchCatastrophes() {
        CatastropheRepositoryImpl().getCatastrophes()
            .sink(receiveCompletion: { completion in
                // Handle completion
            }, receiveValue: { [weak self] (catastrophes: [Catastrophe]?) in
                self?.catastrophes = catastrophes ?? []
            })
            .store(in: &cancellables)
    }
}
