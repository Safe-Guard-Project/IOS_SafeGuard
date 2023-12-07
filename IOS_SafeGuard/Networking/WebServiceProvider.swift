import Combine
import Foundation

class WebServiceProvider {
    static let shared: WebServiceProvider = {
        let instance = WebServiceProvider()
        return instance
    }()

    func callWebService<T: Codable>(
        url: String,
        method: String,
        params: [String: Any]?,
        queryParams: [String: Any]? = nil // Provide a default value for queryParams
    ) -> AnyPublisher<T?, Error> {
        guard var urlComponents = URLComponents(string: url) else {
            return Fail<T?, Error>(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        // Declare request variable here
        var request: URLRequest

        if method.uppercased() == "GET" {
            // Append query parameters if available
            if let queryParams = queryParams {
                urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }

            // Move the declaration of request here for GET requests
            guard let fullURL = urlComponents.url else {
                return Fail<T?, Error>(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }
            request = URLRequest(url: fullURL)
        } else if method.uppercased() == "POST", let params = params {
            // Set the HTTP body for POST requests
            do {
                request = URLRequest(url: urlComponents.url!) // Note: Force unwrapping here assumes fullURL is not nil
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
                // Set the content type to JSON
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                return Fail<T?, Error>(error: NetworkError.invalidData)
                    .eraseToAnyPublisher()
            }
        } else {
            // Handle other HTTP methods here if needed
            return Fail<T?, Error>(error: NetworkError.invalidMethod)
                .eraseToAnyPublisher()
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
