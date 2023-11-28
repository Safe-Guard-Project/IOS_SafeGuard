//
//  InformationView.swift
//  IOS_SafeGuard
//
//  Created by ekbell on 28/11/2023.
//

import SwiftUI

struct InformationView: View {
    let informations = [
        Information (titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation" , pays: "France" , region: "Nice" , descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: "22-5-2023", image: "intro", pourcentageFiabilite: 50 , etat: "Coming" ),
            Information (titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation" , pays: "France" , region: "Nice" , descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: "22-5-2023", image: "intro", pourcentageFiabilite: 50 , etat: "Coming" )
    
    ]
    
    
    var body: some View {
        
        NavigationView {
            List {
                
                
                ForEach(informations) {index in
                    
                    InformationCardView(information: index)
                        .listRowInsets(EdgeInsets(top:2 , leading:5 , bottom: 4, trailing: 4))
                }
            }
            .navigationTitle("Informations").navigationBarTitleDisplayMode(.large)
        }
        
    }
}

#Preview {
    InformationView()
}
