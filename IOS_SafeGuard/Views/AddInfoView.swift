import SwiftUI
import UIKit
import Alamofire


struct AddInfoView: View {

    @State private var title = ""
    @State private var typeOfCatastrophe = "Earthquake" // Default value
    @State private var country = ""
    @State private var region = ""
    @State private var selectedDate = Date()
    @State private var liabilityPercentage = ""
    @State private var descriptionCatastrophe = ""
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false
    @State private var statement: Statement = .ongoing

    enum Statement: String {
        case ongoing = "Ongoing"
        case notYet = "Not Yet"
    }

    @ObservedObject private var viewModel = InformationViewModel()

    var body: some View {
        NavigationView {
          
                Section(header: Text("New Information")) {
                    TextField("Title", text: $title)
                    Picker("Type of Catastrophe", selection: $typeOfCatastrophe) {
                        ForEach(["Earthquake", "Flood", "Fire", "Other"], id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Country", text: $country)
                    TextField("Region", text: $region)
                    DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])

                    VStack(alignment: .leading) {
                        Text("Statement")
                        RadioGroup(selectedOption: $statement, options: [.ongoing, .notYet])
                    }

                    TextField("Liability Percentage", text: $liabilityPercentage)
                        .keyboardType(.decimalPad) // Allow only numeric input
                    VStack(alignment: .leading) {
                        TextField("Description of Catastrophe", text: $descriptionCatastrophe)
                            .frame(height: 100)
                    }
                }

                Section(header: Text("Blog Image")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Button(action: {
                            showImagePicker.toggle()
                        }) {
                            Image(systemName: "arrow.up.to.line.alt")
                                .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 50) // Ajuster la taille de l'icône selon vos besoins
                            .foregroundColor(Color(red: 0.36, green: 0.7, blue: 0.36)) // Couleur de l'icône // Choisissez la couleur appropriée
                                .imageScale(.large) // Choisissez la taille de l'icône
                        }
                    }
                }

                Section {
                    HStack {
                        Spacer()
                        Button(action: sendBlogToServer){
                       
                            Text("Send")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("New Blog")
        }
    }

    struct RadioGroup: View {
        @Binding var selectedOption: AddInfoView.Statement
        var options: [AddInfoView.Statement]

        var body: some View {
            HStack {
                ForEach(options, id: \.self) { option in
                    RadioButton(text: option.rawValue, isSelected: option == selectedOption) {
                        selectedOption = option
                    }
                }
            }
        }
    }

    struct RadioButton: View {
        var text: String
        var isSelected: Bool
        var action: () -> Void

        var body: some View {
            Button(action: {
                action()
            }) {
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    Text(text)
                }
            }
        }
    }


func sendBlogToServer() {
    // Vérifiez si toutes les informations nécessaires sont présentes
    guard let imageData = image?.jpegData(compressionQuality: 0.5) else {
        print("Selected image is missing")
        return
    }

    // Créez l'URL du point de terminaison de votre serveur
    guard let url = URL(string: "https://your-server-endpoint.com/information") else {
        print("Invalid URL")
        return
    }

    // Créez une instance de URLRequest
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    // Créez un objet FormData pour stocker les données du formulaire
    let formData = MultipartFormData()

    // Ajoutez les champs de données au FormData
    AF.upload(multipartFormData: { multipartFormData in
        multipartFormData.append(title.data(using: .utf8) ?? Data(), withName: "titre")
        multipartFormData.append(typeOfCatastrophe.data(using: .utf8) ?? Data(), withName: "typeCatastrophe")

        // Assuming idUser is available in your viewModel
        if let idUser = viewModel.idUser {
            multipartFormData.append(idUser.data(using: .utf8) ?? Data(), withName: "idUser")
        } else {
            print("idUser is missing")
            return
        }

        multipartFormData.append(country.data(using: .utf8) ?? Data(), withName: "pays")
        multipartFormData.append(region.data(using: .utf8) ?? Data(), withName: "region")
        multipartFormData.append(descriptionCatastrophe.data(using: .utf8) ?? Data(), withName: "descriptionInformation")
        multipartFormData.append(selectedDate.description.data(using: .utf8) ?? Data(), withName: "dateDePrevention")

        // Append the image data if it's available
        if let imageData = image?.jpegData(compressionQuality: 0.5) {
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }

        multipartFormData.append(liabilityPercentage.data(using: .utf8) ?? Data(), withName: "pourcentageFiabilite")
        multipartFormData.append(statement.rawValue.data(using: .utf8) ?? Data(), withName: "etat")

    }, to: url)
    .response { response in
        // Gérez la réponse du serveur ou les erreurs éventuelles ici
        if let error = response.error {
            print("Error: \(error)")
            return
        }

        if let data = response.data {
            // Traitez les données de réponse si nécessaire
            let responseString = String(data: data, encoding: .utf8)
            print("Response data: \(responseString ?? "")")
        }
    }
}
