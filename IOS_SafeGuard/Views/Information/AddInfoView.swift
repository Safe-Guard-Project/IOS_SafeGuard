


import SwiftUI
import Alamofire



struct AddInfoView: View {
    @State private var title = ""
    @State private var typeOfCatastrophe = "Earthquake"
    @State private var country = ""
    @State private var region = ""
    @State private var selectedDate = Date()
    @State private var liabilityPercentage = ""
    @State private var descriptionCatastrophe = ""
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false
    @State private var statement: Statement = .ongoing

    enum Statement: String {
        case ongoing = "En cours"
        case notYet = "Pas encore"
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: SectionHeader("Nouveau Blog"))
                {
                    TextField("Titre", text: $title )
                        .accentColor(.blue)
                      // Apply a black border
                    Picker("Type de Catastrophe", selection: $typeOfCatastrophe) {
                        ForEach(["Earthquake", "Tsunami", "Inondation", "Tornade", "Autres"], id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Pays", text: $country)
                    TextField("Région", text: $region)
                   
                    VStack {
                        DatePicker("Date et heure" ,selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .accentColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }

                    HStack {
                        Spacer()
                        RadioGroup(selectedOption: $statement, options: [.ongoing, .notYet])
                        Spacer()
                    }

                    TextField("Pourcentage de fiabilité", text: $liabilityPercentage)
                        .keyboardType(.decimalPad)
                    TextField("Description", text: $descriptionCatastrophe)
                        .frame(height: 100)

                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } else {
                        HStack {
                            Spacer()
                            Button(action: {
                                showImagePicker.toggle()
                            }) {
                                Image(systemName: "arrow.up.to.line.alt")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 50)
                                    .foregroundColor(.blue)
                                    .imageScale(.large)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }

                    Button(action: sendInformationToServer) {
                        Text("AJOUTER")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
              
                
            }
            
            .navigationBarTitle("", displayMode: .inline)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $image, showImagePicker: $showImagePicker)
            }
        }
    }

    struct SectionHeader: View {
        let title: String

        init(_ title: String) {
            self.title = title
        }

        var body: some View {
            HStack {
                Spacer()
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
                Spacer()
            }
        }
    }

    struct RadioGroup: View {
        @Binding var selectedOption: AddInfoView.Statement
        var options: [AddInfoView.Statement]

        var body: some View {
            HStack {
                ForEach(options, id: \.self) { option in
                    RadioButton(
                        text: option.rawValue,
                        isSelected: option == selectedOption,
                        action: { selectedOption = option }
                    )
                }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }


    struct RadioButton: View {
        var text: String
        var isSelected: Bool
        var action: () -> Void

        var body: some View {
            Button(action: action) {
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    Text(text)
                }
            }
            .contentShape(Rectangle()) // Set the content shape to allow interaction
        }
    }


    func sendInformationToServer() {
       /* guard (image?.jpegData(compressionQuality: 0.5)) != nil else {
            print("Selected image is missing")
            return
        }*/

        guard let url = URL(string: "http://localhost:9090/information") else {
            print("Invalid URL")
            return
        }

        AF.upload(multipartFormData: { multipartFormData in
            // Add information details
            multipartFormData.append(title.data(using: .utf8) ?? Data(), withName: "titre")
            multipartFormData.append(typeOfCatastrophe.data(using: .utf8) ?? Data(), withName: "typeCatastrophe")
            multipartFormData.append(country.data(using: .utf8) ?? Data(), withName: "pays")
            multipartFormData.append(region.data(using: .utf8) ?? Data(), withName: "region")
            multipartFormData.append(descriptionCatastrophe.data(using: .utf8) ?? Data(), withName: "descriptionInformation")
            multipartFormData.append(selectedDate.description.data(using: .utf8) ?? Data(), withName: "dateDePrevention")

            if let imageData = image?.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }

            multipartFormData.append(liabilityPercentage.data(using: .utf8) ?? Data(), withName: "pourcentageFiabilite")
            multipartFormData.append(statement.rawValue.data(using: .utf8) ?? Data(), withName: "etat")

            // Add additional fields if needed
            multipartFormData.append("AdditionalField1Value".data(using: .utf8) ?? Data(), withName: "additionalField1")
            multipartFormData.append("AdditionalField2Value".data(using: .utf8) ?? Data(), withName: "additionalField2")

        }, to: url)
        .response { response in
            if let error = response.error {
                print("Error: \(error)")
                if let data = response.data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response data: \(error  )")
                }
                return
            }

            if let data = response.data {
                do {
                    let decoder = JSONDecoder()
                    // Parse the information
                    let information = try decoder.decode(Information.self, from: data)

                    // Handle the server response here
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response data: \(responseString ?? "")")

                    // Optionally, you can use the information data as needed.
                    print("New information created: \(information)")
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }
    }



    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: UIImage?
        @Binding var showImagePicker: Bool

        func makeCoordinator() -> Coordinator {
            return Coordinator(parent: self)
        }

        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .photoLibrary
            return picker
        }

        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            let parent: ImagePicker

            init(parent: ImagePicker) {
                self.parent = parent
            }

            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let image = info[.originalImage] as? UIImage {
                    parent.selectedImage = image
                }
                parent.showImagePicker = false
            }

            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.showImagePicker = false
            }
        }
    }
}
