//
//  AlamofireCatastropheApi.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import Foundation
import Alamofire

class AlamofireCatastropheApi: CatastropheApi {
    func getCatastrophes(completion: @escaping (Result<[Catastrophe], Error>) -> Void) {
        // Use Alamofire to make a network request and fetch catastrophes
        AF.request("http://localhost/catastrophe")
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

