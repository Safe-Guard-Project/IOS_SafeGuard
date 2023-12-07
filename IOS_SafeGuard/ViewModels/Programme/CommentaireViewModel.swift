//
//  CommentaireViewModel.swift
//  IOS_SafeGuard
//
//  Created by abir on 1/12/2023.
//

import Foundation
import Combine

class CommentViewModel: ObservableObject {
    @Published var comments: [Commentaire] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func addComment(textComment: String, idCoursProgramme: String) {
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme") else {
            return
        }
        
        let commentData: [String: Any] = [
            "textComment": textComment,
            "idCoursProgramme": idCoursProgramme
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
                let newComment = try JSONDecoder().decode(Commentaire.self, from: data)
                
                DispatchQueue.main.async {
                    self.comments.append(newComment)
                }
            } catch {
                print("Error decoding comment response: \(error)")
            }
        }.resume()
    }
    
    
    func getAllComments() {
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Commentaire].self, decoder: JSONDecoder())
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
    func deleteComment(comment: Commentaire) {
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme/\(comment.id)") else {
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
    func updateComment(commentID: String, textComment: String, idCoursProgramme: String) {
        guard validateInputs(textComment: textComment, idCoursProgramme: idCoursProgramme) else {
            return
        }

        let updatedComment = Commentaire(
            id: commentID,
            textComment: textComment,
            idCoursProgramme: idCoursProgramme
        )

        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(updatedComment) else {
            print("Failed to encode data")
            return
        }

        guard let url = URL(string: "http://localhost:9090/commentairesProgramme/\(commentID)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let updatedComment = try JSONDecoder().decode(Commentaire.self, from: data)
                        if let index = self.comments.firstIndex(where: { $0.id == updatedComment.id }) {
                            self.comments[index] = updatedComment
                        }
                    } catch {
                        print("Error decoding updated comment response: \(error)")
                    }
                }
            }
        }.resume()
    }
    func validateInputs(textComment: String, idCoursProgramme: String) -> Bool {
            if textComment.isEmpty || idCoursProgramme.isEmpty {
                print("Validation failed: Text comment or ID is empty.")
                return false
            }
            return true
        }
}
 /*
import Foundation
import Combine

class CommentViewModel: ObservableObject {
    @Published var comments: [Commentaire] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func addComment(textComment: String, idCoursProgramme: String) {
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme") else {
            return
        }
        
        let commentData: [String: Any] = [
            "textComment": textComment,
            "idCoursProgramme": idCoursProgramme
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
                let newComment = try JSONDecoder().decode(Commentaire.self, from: data)
                
                DispatchQueue.main.async {
                    self.comments.append(newComment)
                }
            } catch {
                print("Error decoding comment response: \(error)")
            }
        }.resume()
    }
    
    func getAllComments() {
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Commentaire].self, decoder: JSONDecoder())
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
    
    func deleteComment(comment: Commentaire) {
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme/\(comment.id)") else {
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
    
    func updateComment(commentID: String, textComment: String, idCoursProgramme: String) {
        guard validateInputs(textComment: textComment, idCoursProgramme: idCoursProgramme) else {
            return
        }
        
        let updatedComment = Commentaire(
            id: commentID,
            textComment: textComment,
            idCoursProgramme: idCoursProgramme
        )
        
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(updatedComment) else {
            print("Failed to encode data")
            return
        }
        
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme/\(commentID)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    if let responseJson = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("Response: \(responseJson)")
                        // Handle the successful response if needed
                    }
                }
            }
        }.resume()
    }
    
    func validateInputs(textComment: String, idCoursProgramme: String) -> Bool {
        if textComment.isEmpty || idCoursProgramme.isEmpty {
            print("Validation failed: Text comment or ID is empty.")
            return false
        }
        return true
    }
}*/
