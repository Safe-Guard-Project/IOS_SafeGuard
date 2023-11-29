//
//  Information.swift
//  IOS_SafeGuard
//
//  Created by ekbell on 28/11/2023.
//

import Foundation
struct Information: Identifiable {
    let id = UUID()
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
let informations = [
    Information (titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation" , pays: "France" , region: "Nice" , descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: Date(), image: "intro", pourcentageFiabilite: 50 , etat: "Coming" ),
        Information (titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation" , pays: "France" , region: "Nice" , descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: Date(), image: "intro", pourcentageFiabilite: 50 , etat: "Coming" )

]
