//
//  Information.swift
//  IOS_SafeGuard
//
//  Created by ekbell on 28/11/2023.
//

import Foundation
struct Information: Codable {
    let titre: String
    let typeCatastrophe: String

    let pays: String
    let region: String
    let descriptionInformation: String
    let dateDePrevention: Date
    let image: String
    let pourcentageFiabilite: Double
    let etat: String
    
    
}
