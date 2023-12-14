//
//  CommentInfoViewModel.swift
//  IOS_SafeGuard
//
//  Created by EkbelZrelli on 13/12/2023.
//

import Foundation
import Combine

class CommentInfoViewModel: ObservableObject {
    @Published var comments: [CommentaireInfo] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func addComment(descriptionCommentaire: String, idInformation: String) {
        guard let url = URL(string: "http://localhost:9090/commentairesinformation") else {
            return
        }
        
        let commentData: [String: Any] = [
            "descriptionCommentaire": descriptionCommentaire,
            "idInformation": idInformation
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: commentData)
        } catch {
            print("Error encoding comment data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let newComment = try JSONDecoder().decode(CommentaireInfo.self, from: data)
                
                DispatchQueue.main.async {
                    self.comments.append(newComment)
                }
            } catch {
                print("Error decoding comment response: \(error)")
            }
        }.resume()
    }
    func getAllComments() {
        guard let url = URL(string: "http://localhost:9090/commentairesinformation") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CommentaireInfo].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] fetchedComments in
                self?.comments = fetchedComments
            }
            .store(in: &cancellables)
    }
    
    
    func deleteComment(comment: CommentaireInfo) {
        guard let url = URL(string: "http://localhost:9090/commentairesinformation/\(comment.id)") else {
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
                if let index = self.comments.firstIndex(where: { $0.id == comment.id }) {
                    self.comments.remove(at: index)
                }
            }
        }.resume()
    }
}
