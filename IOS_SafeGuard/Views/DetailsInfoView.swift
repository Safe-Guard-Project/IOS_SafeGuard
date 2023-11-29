import SwiftUI

struct DetailsInfoView: View {
    var information: Information
    @State private var commentText: String = ""
    @State private var comments: [String] = []
    @Environment(\.presentationMode) var presentationMode

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

                Text("Type of Catastrophe: \(information.typeCatastrophe)")
                    .padding(.horizontal)
                Text("Country: \(information.pays)")
                    .padding(.horizontal)
                Text("Region: \(information.region)")
                    .padding(.horizontal)
                Text("Statement: \(information.etat)")
                    .padding(.horizontal)
                Text("Prevention Date: \(formatDate(information.dateDePrevention))")
                    .padding(.horizontal)
                Text("Liabilities Percent: \(information.pourcentageFiabilite)%")
                    .padding(.horizontal)

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
        .navigationBarTitle("Information Detail", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            },
            trailing: Button(action: {
                shareInformation()
            }) {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
        )
        .background(
            VStack {
                Spacer()
                HStack {
                    TextField("Add a Comment", text: $commentText)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                        .padding([.leading, .bottom], 10)
                        .frame(height: 50)

                    Button(action: {
                        comments.append(commentText)
                        commentText = ""
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.blue)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal) // Adjusted for spacing
                .background(Color(UIColor.systemBackground))
            }
        )
    }

    private func shareInformation() {
        let shareMessage = "Check out this information: \(information.titre)"
        let activityViewController = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct DetailsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsInfoView(information: Information(titre: "Comments", typeCatastrophe: "Comments", pays: "", region: "", descriptionInformation: "Leave your comments here.", dateDePrevention: Date(), image: "Intro", pourcentageFiabilite: 0, etat: ""))
    }
}
