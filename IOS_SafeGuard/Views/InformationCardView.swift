// InformationCardView.swift
import SwiftUI

struct InformationCardView: View {
    var information: Information
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Info image
            Image(information.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            
            // Info details
            VStack(alignment: .leading, spacing: 8) {
                // Event title
                Text(information.titre)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center) // Center the title

                // Event description
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

struct InformationCardView_Previews: PreviewProvider {
    static var previews: some View {
        InformationCardView(information: Information(
            id: "1",
            titre: "Une inondation au bout de 3 heures !!! ",
            typeCatastrophe: "inondation",
            idUser: "userID",
            pays: "France",
            region: "Nice",
            descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures",
            dateDePrevention: Date(),
            image: "Intro",
            pourcentageFiabilite: 50,
            etat: "Coming"
        ))
    }
}
