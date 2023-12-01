import SwiftUI

struct ProfileCardView: View {
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

            HStack {
                Spacer()

                // Edit icon
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        // Handle edit action
                        print("Edit tapped")
                    }

                // Delete icon
                Image(systemName: "trash.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .onTapGesture {
                        // Handle delete action
                        print("Delete tapped")
                    }

                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(10)
    }
}

struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardView(information: Information(id: "gg", titre: "Sample Title", typeCatastrophe: "Sample Type", idUser: "", pays: "Sample Country", region: "Sample Region", descriptionInformation: "Sample Description", dateDePrevention: Date(), image: "sampleImage", pourcentageFiabilite: 50, etat: "Sample State"))
    }
}
