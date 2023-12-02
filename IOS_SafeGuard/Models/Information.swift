//
//  Information.swift
//  IOS_SafeGuard
//
//  Created by ekbell on 28/11/2023.
//

import Foundation

struct Information: Identifiable, Codable {
    let id: String?
    let titre: String
    let typeCatastrophe: String
    // Ajoutez cette ligne pour faire correspondre la clé 'idUser' dans les données JSON
    let idUser: String
    let pays: String
    let region: String
    let descriptionInformation: String
    let dateDePrevention: Date
    let image: String
    let pourcentageFiabilite: Double
    let etat: String

 


    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case titre
        case typeCatastrophe
        case idUser
        case pays
        case region
        case descriptionInformation
        case dateDePrevention
        case image
        case pourcentageFiabilite
        case etat
    }
}
