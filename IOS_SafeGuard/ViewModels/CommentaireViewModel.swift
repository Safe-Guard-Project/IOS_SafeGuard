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
    
}
