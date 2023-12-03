//
//  CommentaireViewModel.swift
//  IOS_SafeGuard
//
//  Created by abir on 1/12/2023.
//

import Foundation
/*
class CommentViewModel: ObservableObject {
    @Published var comments: [Commentaire] = []

    func addComment(textComment: String, idCoursProgramme: String) {
        // Construction de l'URL backend pour l'ajout de commentaire
        guard let url = URL(string: "http://localhost:9090/commentairesProgramme") else {
            return
        }

        // Construction des données à envoyer
        let commentData: [String: Any] = [
            "textComment": textComment,
            "idCoursProgramme": idCoursProgramme
        ]

        // Configuration de la requête HTTP
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Encodage des données JSON dans le corps de la requête
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: commentData)
        } catch {
            print("Error encoding comment data: \(error)")
            return
        }

        // Envoi de la requête
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Décodage de la réponse JSON
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
}
*/
import Foundation

class CommentViewModel: ObservableObject {
    @Published var comments: [Commentaire] = []

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
}
