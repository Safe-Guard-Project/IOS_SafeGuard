// NetworkError.swift

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case unknownError
    case invalidResponse
    case invalidMethod
    case statusCode(Int)
    case biometricsNotAvailable
    case decodingError(DecodingError)
    // Add more error cases as needed
}
