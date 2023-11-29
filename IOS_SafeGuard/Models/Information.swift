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
    Information(titre: "Les forêts de Ain drahem en danger !!! ", typeCatastrophe: "Incendie", pays: "Tunisie", region: "Ain Drahem", descriptionInformation: "Un incendie de forêt s'est déclaré dans la région de Ain drahem de Tunisie , menaçant plusieurs communautés. Les autorités locales ont émis des ordres d'évacuation dans les zones touchées. Les équipes de lutte contre les incendies sont mobilisées, mais la situation reste critique.", dateDePrevention: Date(), image: "thumbnail-incendie-herve-dermoune", pourcentageFiabilite: 100, etat: "On going"),
    Information(titre: "Tsunami menace l'europe !!! ", typeCatastrophe: "Tsunami", pays: "France", region: "Nice", descriptionInformation: "Une alerte de Tsunami a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: Date(), image: "doc2", pourcentageFiabilite: 70, etat: "Coming")

]
