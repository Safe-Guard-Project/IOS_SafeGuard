//
//  CoursViewModel.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import Foundation
class CoursViewModel : ObservableObject {
    @Published var selectedCourse :Cours?
    var courses :[Cours] = [Cours(type: "Tsunamu", description: "ok"),
                            Cours(type: "Tsunamu", description: "ok"),
                            Cours(type: "Tsunamu", description: "ok"),
]
}
