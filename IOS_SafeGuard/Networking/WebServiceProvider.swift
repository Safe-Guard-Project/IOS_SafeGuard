// WebServiceProvider.swift

import Combine
import Foundation

class WebServiceProvider {
    static let shared: WebServiceProvider = {
        let instance = WebServiceProvider()
        return instance
    }()

    func callWebService<T: Codable>(url: String, method: String, params: [String: Any]?) -> AnyPublisher<T?, Error> {
        guard let fullURL = URL(string: url) else {
            return Fail<T?, Error>(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: fullURL)
        request.httpMethod = method

        // Set the HTTP body if needed
        if let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
                // Set the content type to JSON
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                return Fail<T?, Error>(error: NetworkError.invalidData)
                    .eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.statusCode(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T?.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
