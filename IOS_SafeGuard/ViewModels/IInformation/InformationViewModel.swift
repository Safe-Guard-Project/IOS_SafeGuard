import Foundation

class InformationViewModel: ObservableObject {
    @Published var informations: [Information] = []
    @Published var addedInformation: Information?

    func fetchInformations() {
        guard let url = URL(string: "http://localhost:9090/information") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching information: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([Information].self, from: data)
                DispatchQueue.main.async {
                    self.informations = decodedData
                }
            } catch {
                print("Error decoding information data: \(error.localizedDescription)")
            }
        }.resume()
    }

    func addInformation(title: String, typeCatastrophe: String, idUser: String, pays: String, region: String, description: String, image: Data, dateDePrevention: Date, pourcentageFiabilite: Double, etat: String) {
        
        guard let url = URL(string: "http://localhost:9090/Information") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let informationData: [String: Any] = [
            "titre": title,
            "typeCatastrophe": typeCatastrophe,
            "idUser": idUser,
            "pays": pays,
            "region": region,
            "descriptionInformation": description,
            "image": image.base64EncodedString(),
            "dateDePrevention": dateDePrevention.timeIntervalSince1970,
            "pourcentageFiabilite": pourcentageFiabilite,
            "etat": etat
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: informationData)
        } catch {
            print("Error encoding information data: \(error.localizedDescription)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Error adding information: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let addedInformation = try JSONDecoder().decode(Information.self, from: data)
                DispatchQueue.main.async {
                    self.addedInformation = addedInformation
                }
            } catch {
                print("Error decoding added information data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
