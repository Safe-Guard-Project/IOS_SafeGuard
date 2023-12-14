//
//  ZoneDeDangerViewModel.swift
//  IOS_SafeGuard
//
//  Created by mohamed oussama bouriga on 6/12/2023.
//
import Foundation
import Combine

class ZoneDeDangerViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let repository:ZoneDeDangerRepository

    @Published var zone: [ZoneDeDanger] = []

    init(repository: ZoneDeDangerRepository = ZoneDeDangerRepositoryImpl()) {
        self.repository = repository
    }

    func getZoneDeDangers() {
        repository.getZoneDeDangers()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break // Do nothing on success
                case .failure(let error):
                    print("Error fetching zoneDeDanger: \(error)")
                }
            } receiveValue: { [weak self] fetchedZone in
                guard let self = self else { return }
                self.zone = fetchedZone
            }
            .store(in: &cancellables)
    }
}
