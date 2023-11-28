//
//  CatastropheApiService.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import Foundation
import Alamofire

class CatastropheApiService {
    private let baseURL = "http://192.168.1.105:9090/"  // Update with your actual server URL

    static let shared = CatastropheApiService()

    private init() {}

    func getCatastrophes(completion: @escaping (Result<[Catastrophe], Error>) -> Void) {
        AF.request(baseURL + "catastrophe/")
            .validate()
            .responseDecodable(of: [Catastrophe].self) { response in
                switch response.result {
                case .success(let catastrophes):
                    completion(.success(catastrophes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

