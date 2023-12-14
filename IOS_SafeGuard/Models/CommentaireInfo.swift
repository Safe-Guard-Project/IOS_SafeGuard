//
//  CommentaireInfo.swift
//  IOS_SafeGuard
//
//  Created by ekbell on 29/11/2023.
//

import Foundation

struct CommentaireInfo: Codable , Identifiable {
    let idInformation: String
    let descriptionCommentaire: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case idInformation
        case descriptionCommentaire
        case id = "_id"
    }

    /*init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode idInformation directly as String
        idInformation = try container.decode(String.self, forKey: .idInformation)
        descriptionCommentaire = try container.decode(String.self, forKey: .descriptionCommentaire)
    }*/
}
