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

        // Check if it's a GET request and append query parameters
        if method.uppercased() == "GET", let queryParams = queryParams {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        guard let fullURL = urlComponents.url else {
            return Fail<T?, Error>(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: fullURL)
        request.httpMethod = method

        // Set the HTTP body if needed
        if method.uppercased() == "POST", let params = params {
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
