//
//  NetworkManager.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

/*
import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "http://192.168.1.105:9090/"
    
    private init() { }
    
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(baseURL + endpoint, method: method, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
 */
