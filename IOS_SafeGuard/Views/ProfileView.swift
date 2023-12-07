/*import SwiftUI

struct ProfileView: View {
    @State private var informations = [
        Information(id: "1", titre: "Les forêts de Ain drahem en danger !!! ", typeCatastrophe: "Incendie", idUser: "userID1", pays: "Tunisie", region: "Ain Drahem", descriptionInformation: "Une incendie a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: Date(), image: "thumbnail-incendie-herve-dermoune", pourcentageFiabilite: 100, etat: "On going"),
        Information(id: "2", titre: "Tsunami menace l'europe !!! ", typeCatastrophe: "Tsunami", idUser: "userID2", pays: "France", region: "Nice", descriptionInformation: "Une alerte de Tsunami a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: Date(), image: "doc2", pourcentageFiabilite: 70, etat: "Coming")
    ]

    @State private var isActionButtonVisible = false
    @State private var isAddInfoViewActive = false

    var body: some View {
        NavigationView {
            List {
                ForEach(informations.indices, id: \.self) { index in
                    NavigationLink(destination: DetailsInfoView(information: informations[index])) {
                        InformationCardView(information: informations[index])
                            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                            .swipeActions {
                                // Modifier action
                                Button {
                                    // Handle modifier action
                                    print("Modifier tapped for index \(index)")
                                } label: {
                                    Label("Modifier", systemImage: "pencil.circle")
                                        .foregroundColor(.green)
                                }

                                // Supprimer action
                                Button {
                                    // Handle supprimer action
                                    informations.remove(at: index)
                                } label: {
                                    Label("Supprimer", systemImage: "trash.circle")
                                        .foregroundColor(.red)
                                }
                            }
                    }
                }
                .onDelete { indexSet in
                    informations.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                withAnimation {
                    isActionButtonVisible = true
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}*/
import URLImage

import SwiftUI

struct ProfileView: View {
    @State var informations: [Information] = []
    @State private var isAddingInformation = false
    @State private var selectedInformation: Information?

    var body: some View {
            NavigationView {
                VStack {

                ScrollView {
                    LazyVStack(spacing: 50) { // Ajouter un espacement vertical entre chaque carte
                        ForEach(informations) { info in
                            ProfileCardView(information: info)
                                .onTapGesture {
                                    selectedInformation = info
                                }
                        }
                    }
                    .padding(.horizontal, 20) // Ajouter un espacement horizontal global
                    .padding(.top, 16)
                }
                .navigationBarHidden(true)

            .onAppear {
                fetchInformation()
            }
            .sheet(item: $selectedInformation) { info in
                ProfileDetailView(information: info)
            }
            
                }
            }
        
    }

    struct ProfileCardView: View {
        let information: Information

        var body: some View {
            VStack(spacing: 8) {
               /* AsyncImageView(url: information.image ?? "")
                    .frame(height: 200)

                Spacer()*/
                Image("inondation") // Replace "folderImage" with the actual name of your image asset
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100) // Adjust the height as needed

                        Spacer()


                Text(information.titre ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)

                Spacer()

                Text(information.descriptionInformation)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .frame(height: 300)
        }
    }







    struct ProfileDetailView: View {
        var information: Information
        @State private var commentText: String = ""
        @State private var comments: [String] = []
        struct Comment: Codable {
               let text: String
               let informationID: String
               // Add any other necessary properties
           }

        // Add a binding state to track the share sheet presentation
        @State private var isShareSheetPresented: Bool = false

        var body: some View {
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {

                        HStack {
                            Text(information.titre ?? "")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                                .padding(.horizontal, 16)

                            Spacer()

                            Button(action: {
                                isShareSheetPresented.toggle()
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                            .sheet(isPresented: $isShareSheetPresented) {
                                ShareSheet(activityItems: [information.titre ?? "", information.descriptionInformation])
                            }
                            
                        }
                        .padding(.horizontal)

                   /* if !(information.image?.isEmpty ?? true) {
                        AsyncImageView(url: information.image ?? "")
                            .frame(height: 200)
                    
                        
                    }*/
                        Image("inondation") // Replace "folderImage" with the actual name of your image asset
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 100) // Adjust the height as needed

                                Spacer()


                    titleValueRow(title: "Type de catastrophe :", value: information.typeCatastrophe)
                    titleValueRow(title: "Pays :", value: information.pays)
                    titleValueRow(title: "Region :", value: information.region)
                    titleValueRow(title: "Etat :", value: information.etat)
                    titleValueRow(title: "Date de prevention :", value: formatDate(information.dateDePrevention))
                    titleValueRow(title: "Pourcentage de Fiabilité :", value: "\(information.pourcentageFiabilite)%")

                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description de catastrophe :")
                                    .font(.headline)
                                    .foregroundColor(.black) // Set the header text color to navy blue
                                    .padding(.horizontal)

                                Text(information.descriptionInformation)
                                    .padding(.horizontal)
                                    .foregroundColor(.black) // Set the text color as needed
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .border(Color.black) // Apply a black border to the frame
                            }
                        }
                    if !comments.isEmpty {
                        Divider()
                        Section(header:
                            Text("Commentaires")
                                .font(.headline)
                                .foregroundColor(.blue) // Set the header text color to blue
                                .padding(.leading)
                        ) {
                            ForEach(comments, id: \.self) { comment in
                                HStack {
                                    Text(comment)
                                        .foregroundColor(.blue)
                                        .padding(.leading)
                                    Spacer()
                                }
                            }
                        }
                    }

                    Divider()

                    HStack {
                        TextField("Tapez votre commentaire", text: $commentText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                            .padding()

                        Button(action: {
                            addComment()
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
                    .padding(.horizontal)

                    
                }
                .padding()
            }
            .navigationBarTitle("Détails du Blog", displayMode: .inline)
            
            
            
            
            
        }
        private func addComment() {
            guard let informationID = information.id else {
                print("Cannot add comment without information ID")
                return
            }

            guard !commentText.isEmpty else {
                print("Comment text is empty")
                return
            }

            let comment = CommentaireInfo(id: nil, textComment: commentText)

            guard let url = URL(string: "http://localhost:9090/commentairesinformation") else {
                print("Invalid URL for comment addition")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601
                request.httpBody = try encoder.encode(comment)
            } catch {
                print("Error encoding comment: \(error)")
                return
            }

            // ... rest of the code remains the same
        }



        struct ShareSheet: UIViewControllerRepresentable {
            let activityItems: [Any]
            let applicationActivities: [UIActivity]? = nil

            func makeUIViewController(context: Context) -> UIViewController {
                let controller = UIActivityViewController(
                    activityItems: activityItems,
                    applicationActivities: applicationActivities
                )
                return controller
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }

        private func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: date)
        }

        private func titleValueRow(title: String, value: String?) -> some View {
            HStack {
                Text(title)
                    .bold()
                Spacer()
                if let unwrappedValue = value, !unwrappedValue.isEmpty {
                    Text(unwrappedValue)
                } else {
                    Text("N/A")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }
    }



    func fetchInformation() {
        guard let url = URL(string: "http://localhost:9090/information") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching information: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            do {
                let informationArray = try decoder.decode([Information].self, from: data)

                DispatchQueue.main.async {
                    self.informations = informationArray
                }
            } catch {
                print("Error decoding information: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)")
                } else {
                    print("Unable to convert JSON data to string")
                }
            }
        }.resume()
    }

    struct AsyncImageView: View {
        @StateObject private var imageLoader: ImageLoader

        init(url: String) {
            let urlString = "http://localhost:9090/" + url
            _imageLoader = StateObject(wrappedValue: ImageLoader(url: urlString))
        }

        var body: some View {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }

    class ImageLoader: ObservableObject {
        @Published var image: UIImage?

        init(url: String) {
            guard let imageURL = URL(string: url) else { return }

            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            }.resume()
        }
    }

    struct MyProfileView_Previews: PreviewProvider {
        static var previews: some View {
            InformationView()
        }
    }
}

