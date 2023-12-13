//
//  FavorieViewModel.swift
//  IOS_SafeGuard
//
//  Created by abir on 4/12/2023.
//

import Foundation

import Combine

class FavorieViewModel: ObservableObject {
    @Published var favories: [Favorie] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var coursDetails: Cours? 
    
    func addFav( idCoursProgramme: String) {
        guard let url = URL(string: "http://localhost:9090/favorie") else {
            return
        }
        
        let favData: [String: Any] = [
          
            "idCoursProgramme": idCoursProgramme
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: favData)
        } catch {
            print("Error encoding Fav data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let newFav = try JSONDecoder().decode(Favorie.self, from: data)
                
                DispatchQueue.main.async {
                    self.favories.append(newFav)
                }
            } catch {
                print("Error decoding comment response: \(error)")
            }
        }.resume()
    }
    
    func getAllFav() {
        guard let url = URL(string: "http://localhost:9090/favorie/cours") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Favorie].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] fetchedFavories in
                self?.favories = fetchedFavories
            }
            .store(in: &cancellables)
    }
    func deletefav(favorie: Favorie) {
        guard let url = URL(string: "http://localhost:9090/favorie/\(favorie.id)") else {
            return
        }
        
        print("Deleting favorie at URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting fav: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status: \(httpResponse.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let index = self.favories.firstIndex(where: { $0.id == favorie.id }) {
                    self.favories.remove(at: index)
                    print("Favorie deleted successfully")
                } else {
                    print("Favorie not found in the array")
                }
            }
        }.resume()
    }
    
    
    
   
}
