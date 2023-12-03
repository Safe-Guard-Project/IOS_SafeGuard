//
//  Commentaire.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//
/*
import Foundation
struct Commentaire:Identifiable {
    let id = UUID()
    let textComment: String
    //let idCoursProgramme :String
    //let idUser : String
}

*/
import Foundation

struct Commentaire: Codable, Identifiable {
    let id: String
    let textComment: String
    let idCoursProgramme: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case textComment
       case idCoursProgramme
    }
}


