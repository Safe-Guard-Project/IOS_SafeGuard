//
//  ProfileViewModel.swift
//  IOS_SafeGuard
//
//  Created by EkbelZrelli on 14/12/2023.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var information: [Information] = []
    private var cancellables: Set<AnyCancellable> = []
    
    
    func deleteBlog(information: Information) {
        guard let url = URL(string: "http://localhost:9090/information/\(information.id)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error deleting comment: \(error!)")
                return
            }
            
            DispatchQueue.main.async {
                if let index = self.information.firstIndex(where: { $0.id == information.id }) {
                    self.information.remove(at: index)
                }
            }
        }.resume()
    }
    
    
    
    
    
}
