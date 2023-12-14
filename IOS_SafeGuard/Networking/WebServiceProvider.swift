import Combine
import Foundation

class WebServiceProvider {
    static let shared: WebServiceProvider = {
        let instance = WebServiceProvider()
        return instance
    }()
    func uploadFile(url: URL, fileData: Data, fileName: String, fileKey: String) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        
        // Add file data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Add any additional parameters if needed
        /*
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"paramName\"\r\n\r\n".data(using: .utf8)!)
        body.append("paramValue".data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)
        */
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }




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
