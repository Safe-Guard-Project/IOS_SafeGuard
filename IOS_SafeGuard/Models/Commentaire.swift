//
//  Commentaire.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

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

/*

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
    init(id : String="",
         textComment: String,
         idCoursProgramme: String
    ){
        self.id=id
        self.textComment=textComment
        self.idCoursProgramme=idCoursProgramme
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.textComment = try container.decode(String.self, forKey: .textComment)
        self.idCoursProgramme = try container.decode(String.self, forKey: .idCoursProgramme)
    }
    func encode(to encoder: Encoder) throws {
        var container=encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(textComment, forKey: .textComment)
        try container.encode(idCoursProgramme, forKey: .idCoursProgramme)
        
    }
}
*/
