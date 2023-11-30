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

                titleValueRow(title: "Type of Catastrophe", value: information.typeCatastrophe)
                titleValueRow(title: "Country", value: information.pays)
                titleValueRow(title: "Region", value: information.region)
                titleValueRow(title: "Statement", value: information.etat)
                titleValueRow(title: "Prevention Date", value: formatDate(information.dateDePrevention))
                titleValueRow(title: "Liabilities Percent", value: "\(information.pourcentageFiabilite)%")

                Text("Description of Catastrophe:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(information.descriptionInformation)
                    .padding(.horizontal)

                if !comments.isEmpty {
                    Divider()
                    Text("Comments:")
                        .font(.headline)
                        .padding(.leading)

                    ForEach(comments, id: \.self) { comment in
                        HStack {
                            Text(comment)
                                .foregroundColor(.blue)
                                .padding(.leading)
                            Spacer()
                        }
                    }
                }

                Divider()
                HStack {
                    TextField("Type your comment here", text: $commentText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))

                    Button(action: {
                        comments.append(commentText)
                        commentText = ""
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
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

    private func titleValueRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Text(value)
        }
        .padding(.horizontal)
    }
}

struct DetailsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsInfoView(information: Information(titre: "Comments", typeCatastrophe: "Comments", pays: "", region: "", descriptionInformation: "Leave your comments here.", dateDePrevention: Date(), image: "Intro", pourcentageFiabilite: 0, etat: ""))
    }
}
