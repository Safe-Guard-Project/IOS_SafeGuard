import SwiftUI

struct DetailsInfoView: View {
    var information: Information

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(information.titre)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                if !information.image.isEmpty {
                   
                    Image(information.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(.horizontal)
                }

                DetailRow(title: "Type of Catastrophe", value: information.typeCatastrophe)
                DetailRow(title: "Country", value: information.pays)
                DetailRow(title: "Region", value: information.region)
                DetailRow(title: "Statement", value: information.etat)
                DetailRow(title: "Prevention Date", value: formatDate(information.dateDePrevention))
                DetailRow(title: "Liabilities Percent", value: "\(information.pourcentageFiabilite)%")

                Text("Description of Catastrophe:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(information.descriptionInformation)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Information Detail")
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            Spacer()
            Text(value)
                .padding(.horizontal)
        }
    }
}

struct DetailsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsInfoView(information: Information(titre: "Sample Information", typeCatastrophe: "Earthquake", pays: "Country", region: "Region", descriptionInformation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", dateDePrevention: Date(), image: "intro", pourcentageFiabilite: 75, etat: "Ongoing"))
    }
}
