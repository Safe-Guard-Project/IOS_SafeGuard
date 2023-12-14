import Foundation
import Combine

class AddInfoViewModel: ObservableObject {
    @Published var information: [Information] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func addInfo( id: String?,
                  titre: String,
                  typeCatastrophe: String,
                  pays: String,
                  region: String,
                  descriptionInformation: String,
                  dateDePrevention: Date,
                  image: String,
                  pourcentageFiabilite: Int,
                  etat: String,
                  createdAt: Date,
                  updatedAt: Date,
                  __v: Int) {
        guard let url = URL(string: "http://localhost:9090/information") else {
            return
        }
        
        let infoData: [String: Any] = [
            "titre": titre,
            "typeCatastrophe": typeCatastrophe,
            "pays": pays,
            "region": region,
            "descriptionInformation": descriptionInformation,
            "dateDePrevention": descriptionInformation,
            "pourcentageFiabilite": pourcentageFiabilite,
            "etat": etat,
            "image": image
        ]

        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: infoData)
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
                let newInfo = try JSONDecoder().decode(Information.self, from: data)
                
                DispatchQueue.main.async {
                    self.information.append(newInfo)
                }
            } catch {
                print("Error decoding comment response: \(error)")
            }
        }.resume()
    }
}
