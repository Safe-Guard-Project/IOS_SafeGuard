//
//  Favorie.swift
//  IOS_SafeGuard
//
//  Created by abir on 4/12/2023.
//

import Foundation
struct Favorie: Codable, Identifiable {
    let id: String
    let idCoursProgramme: String
   
    enum CodingKeys: String, CodingKey {
        case id = "_id"
       case idCoursProgramme
       
    }
}
