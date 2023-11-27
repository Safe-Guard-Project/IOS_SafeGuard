// NetworkError.swift

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case unknownError
    case invalidResponse
    case statusCode(Int)
    // Add more error cases as needed
}
