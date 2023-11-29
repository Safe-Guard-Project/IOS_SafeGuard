import SwiftUI

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

struct DetailsInfoView: View {
    var information: Information
    @State private var commentText: String = ""
    @State private var comments: [String] = []

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

                // Display comments if available
                if !comments.isEmpty {
                    Divider()
                    Text("Comments:")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(comments, id: \.self) { comment in
                        Text(comment)
                            .padding(.horizontal)
                    }
                }

                // Add a new case for comments
                if information.typeCatastrophe.lowercased() == "comments" {
                    Divider()
                    Text("Add a Comment:")
                        .font(.headline)
                        .padding(.horizontal)
                    TextField("Type your comment here", text: $commentText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button(action: {
                        // Add logic to submit the comment
                        comments.append(commentText)
                        commentText = ""
                    }) {
                        Text("Submit Comment")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Information Detail")
        
        
        HStack {
                            TextField("Ajouter un commentaire", text: $commentText)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                                .padding([.leading, .bottom], 10)
                                .frame(height: 50)

                            Button(action: {
                                
                            }) {
                                Image(systemName: "arrow.right.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.blue)
                                    .padding(.trailing, 10)
                            }
                        }
                        .background(Color(UIColor.systemBackground))
                    }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }


struct DetailsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsInfoView(information: Information(titre: "Comments", typeCatastrophe: "Comments", pays: "", region: "", descriptionInformation: "Leave your comments here.", dateDePrevention: Date(), image: "", pourcentageFiabilite: 0, etat: ""))
    }
}


