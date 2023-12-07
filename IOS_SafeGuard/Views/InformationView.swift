/*// InformationView.swift
import SwiftUI

struct InformationView: View {
    @State var informations: [Information] = []
    @State private var isAddingInformation = false
    
    @State private var selectedInformation: Information?
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(informations, id: \.id) { event in
                        VStack(alignment: .leading, spacing: 8) {
                            InfoCardView(information: Information)
                                .onTapGesture {
                                    selectedInformation = Information
                                }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 16)
            }
            
            .navigationBarTitle("Blog")
            .onAppear {
                fetchInformation()
            }
            
            .sheet(item: $selectedInformation) { event in
                InfoDetailView(information: <#T##Information#>)
            }
            .sheet(isPresented: $isAddingInformation) {
                AddInfoView()
            }
            Spacer()
            
        }
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    isAddingInformation = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .padding()
                        .frame(width: 20, height: 20) // Ajuster la taille de l'icône selon vos besoins
                        .foregroundColor(Color.blue) // Couleur de l'icône // Choisissez la couleur appropriée
                        .imageScale(.large) // Choisissez la
                }
            }
        )
        
        
    }
}
struct InfoCardView: View {
    let information: Information

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImageView(url: information.image )
                .frame(height: 200) // Taille de l'image en vedette

            Text(information.titre)
                .font(.headline)
                .foregroundColor(.primary)
            Text(information.descriptionInformation)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
struct InfoDetailView: View {
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

                if let image = information.image, !image.isEmpty {
                    Image(image)
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
                        .padding()

                    Button(action: {
                        if !commentText.isEmpty {
                            comments.append(commentText)
                            commentText = ""
                        }
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

                HStack {
                    Button(action: {
                        // Add action for sharing information
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitle("Information Detail", displayMode: .inline)
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
            if let unwrappedValue = value {
                Text(unwrappedValue)
            } else {
                Text("N/A")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }




func fetchInformation() {
    guard let url = URL(string: "http://localhost:9090/information") else {
        print("URL invalide")
        return
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            print("Erreur lors de la récupération des événements : \(error)")
            return
        }

        guard let data = data else {
            print("Aucune donnée trouvée")
            return
        }

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let jsonDictionary = json as? [String: Any], let eventList = jsonDictionary["list"] as? [[String: Any]] {
                let jsonData = try JSONSerialization.data(withJSONObject: eventList)
                let fetchedInfos = try decoder.decode([Information].self, from: jsonData)
                DispatchQueue.main.async {
                    self.informations = fetchedInfos
                }
            } else {
                print("La structure JSON ne correspond pas")
            }
        } catch {
            print("Erreur de décodage JSON : \(error)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON reçu : \(jsonString)")
            } else {
                print("Impossible de convertir les données JSON en chaîne")
            }
        }

    }.resume()
}




struct AsyncImageView: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(url: String) {
        let urlString = "http://localhost:9090/" + url // Assurez-vous que l'URL est correctement formée ici
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: urlString))
    }
    
    var body: some View {
        if let uiImage = imageLoader.image {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            // Placeholder image ou indicateur de chargement
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

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}*/


import SwiftUI

struct InformationView: View {
    @State var informations: [Information] = []
    @State private var isAddingInformation = false
    @State private var selectedInformation: Information?

    var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        Text("Blog")
                                                .font(.title)
                                                .foregroundColor(Color.blue)
                                                .padding()
                                            
                        Spacer() // Pousse le bouton à droite
                        
                        // Déplacer le bouton en haut
                        Button(action: {
                            isAddingInformation = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .padding()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.blue)
                                .imageScale(.large)
                        }
                        .padding()
                    }
                ScrollView {
                    LazyVStack(spacing: 50) { // Ajouter un espacement vertical entre chaque carte
                        ForEach(informations) { info in
                            InformationCardView(information: info)
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
                InformationDetailView(information: info)
            }
            .sheet(isPresented: $isAddingInformation) {
                AddInfoView()
            }
                }
            }
        
    }

    struct InformationCardView: View {
        let information: Information

        var body: some View {
            VStack(spacing: 8) {
                AsyncImageView(url: information.image ?? "")
                    .frame(height: 200)

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







    struct InformationDetailView: View {
        var information: Information
        @State private var commentText: String = ""
        @State private var comments: [String] = []

        // Add a binding state to track the share sheet presentation
        @State private var isShareSheetPresented: Bool = false

        var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {

                    // Centered Blue Title
                    Text(information.titre ?? "")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    if !(information.image?.isEmpty ?? true) {
                        AsyncImageView(url: information.image ?? "")
                            .frame(height: 200)
                    }

                    titleValueRow(title: "Type de catastrophe :", value: information.typeCatastrophe)
                    titleValueRow(title: "Pays :", value: information.pays)
                    titleValueRow(title: "Region :", value: information.region)
                    titleValueRow(title: "Etat :", value: information.etat)
                    titleValueRow(title: "Date de prevention :", value: formatDate(information.dateDePrevention))
                    titleValueRow(title: "Pourcentage de Fiabilité :", value: "\(information.pourcentageFiabilite)%")

                    Section(header: Text("Description de catastrophe :").font(.headline).padding(.horizontal)) {
                        Text(information.descriptionInformation)
                            .padding(.horizontal)
                    }

                    if !comments.isEmpty {
                        Divider()
                        Section(header: Text("Commentaires").font(.headline).padding(.leading)) {
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
                            if !commentText.isEmpty {
                                comments.append(commentText)
                                commentText = ""
                            }
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

                    HStack {
                        Spacer() // Add Spacer to push the buttons to the right

                        // Share Button
                        Button(action: {
                            isShareSheetPresented.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black) // Set the color to black
                                .padding()
                                .background(Color.white) // Set the background to white
                                .cornerRadius(10)
                        }
                        .sheet(isPresented: $isShareSheetPresented) {
                                               // Use the ShareSheet view here
                                               ShareSheet(activityItems: [information.titre ?? "", information.descriptionInformation])
                                           }

                       
                    
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarTitle("Détails du Blog", displayMode: .inline)
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

    struct MyInformationView_Previews: PreviewProvider {
        static var previews: some View {
            InformationView()
        }
    }
}

