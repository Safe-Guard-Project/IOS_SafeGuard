//
//  InformationCardView.swift
//  IOS_SafeGuard
//
//  Created by ekbell on 28/11/2023.
//

import SwiftUI

struct InformationCardView: View {
    var information : Information
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //info image
            Image("Intro")
            Image(information.image)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(height: 200)
                .clipped()
            
            //info details
            VStack(alignment: .leading, spacing:8 ) {
                //event title
                Text("Une inondation Dans 3 heures !!!")
                Text(information.titre)
                    .font(.title)
                    .fontWeight(.medium)
                
                //event description
                Text("Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures")
                Text(information.descriptionInformation)
                    .font(.body)
                    .foregroundColor(.secondary)
                
            }
        
        .padding(16)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(10)


    }
}

#Preview {
    InformationCardView(information: Information (titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation" , pays: "France" , region: "Nice" , descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: "22-5-2023", image: "intro", pourcentageFiabilite: 50 , etat: "Coming" ))

}
