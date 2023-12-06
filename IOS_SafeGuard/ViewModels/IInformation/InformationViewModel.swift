/*import Foundation

class InformationViewModel: ObservableObject {
    @Published var informations: [Information] = []
    @Published var addedInformation: Information?

    func getAllInformation() {
        guard let url = URL(string: "http://localhost:9090/information/") else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()

                // Attempt to decode as a single Information object
                let decodedData = try decoder.decode(Information.self, from: data)
                DispatchQueue.main.async {
                    // Handle the single object as needed
                    // You can append it to the array or use it directly
                    self.addedInformation = decodedData
                }

            } catch {
                do {
                    // Attempt to decode as a dictionary
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Check if the response is an error
                        if let errorObject = jsonObject["error"] as? [String: Any], !errorObject.isEmpty {
                            print("Error in API response: \(errorObject)")
                            // Handle the error as needed (e.g., show an alert)
                        }
                    } else {
                        // Unable to decode as a dictionary, log the decoding error
                        print("Error decoding data: \(error)")
                    }
                } catch {
                    // If decoding as both dictionary and Information object fails, log the error
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    
    
    
    func sendInformationToServer(_ information: Information) {
            guard let url = URL(string: "http://localhost:9090/information") else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601

                let jsonData = try encoder.encode(information)
                request.httpBody = jsonData
            } catch {
                print("Error encoding information data: \(error.localizedDescription)")
                return
            }

            // Perform the network request
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error sending data to server: \(error.localizedDescription)")
                    return
                }

                // Handle the response and data as needed
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(Information.self, from: data)
                        DispatchQueue.main.async {
                            self.addedInformation = decodedData
                        }
                    } catch {
                        print("Error decoding server response: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
}*/
