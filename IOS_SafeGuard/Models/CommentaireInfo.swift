//
//  CommentaireInfo.swift
//  IOS_SafeGuard
//
//  Created by ekbell on 29/11/2023.
//

import Foundation

struct CommentaireInfo: Identifiable, Codable {
    let id: UUID?
    let textComment: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case textComment
    }
}
