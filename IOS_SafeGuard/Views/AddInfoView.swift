// AddInfoView.swift
import SwiftUI

struct AddInfoView: View {
    var information: Information?

    @State private var title = ""
    @State private var typeOfCatastrophe = "Earthquake" // Default value
    @State private var country = ""
    @State private var region = ""
    @State private var selectedDate = Date()
    @State private var isOngoing = true
    @State private var liabilityPercentage = ""
    @State private var selectedImage: Image?
    @State private var descriptionCatastrophe = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    enum Statement: String {
        case ongoing = "Ongoing"
        case notYet = "Not Yet"
    }

    @State private var statement: Statement = .ongoing

    var body: some View {
        NavigationView {
            Form {
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
                        HStack {
                            RadioGroup(selectedOption: $statement, options: [.ongoing, .notYet])
                        }
                    }

                    TextField("Liability Percentage", text: $liabilityPercentage)
                        .keyboardType(.decimalPad) // Allow only numeric input
                    VStack(alignment: .leading) {
                        TextField("Description of Catastrophe", text: $descriptionCatastrophe)
                            .frame(height: 100)
                    }
                }

                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showingImagePicker = true
                        }) {
                            Image(systemName: "camera")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$inputImage, isPresented: self.$showingImagePicker)
                        }
                        Spacer()
                    }
                }

                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Add logic to send the form data
                            print("Send button tapped")

                            // You can use the entered data here, e.g., save it to your model
                            let newInformation = Information(
                                id: UUID().uuidString,
                                titre: title,
                                typeCatastrophe: typeOfCatastrophe,
                                idUser: "", // You need to handle user ID
                                pays: country,
                                region: region,
                                descriptionInformation: descriptionCatastrophe,
                                dateDePrevention: selectedDate,
                                image: "", // You need to handle the image logic here
                                pourcentageFiabilite: Double(liabilityPercentage) ?? 0,
                                etat: statement.rawValue
                            )

                            // Make a network request to send the new information
                            sendInformationToServer(newInformation)

                            // You can now use newInformation as needed
                        }) {
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
            .navigationTitle("New Information")
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        selectedImage = Image(uiImage: inputImage)
    }

    // Function to send the information to the server
    func sendInformationToServer(_ information: Information) {
        guard let url = URL(string: "http://127.0.0.1:9090/information") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            // Convert information object to JSON data
            var jsonData = try JSONEncoder().encode(information)
            
            // If an image is selected, convert it to base64 and add it to the JSON data
            if let inputImage = inputImage, let imageData = inputImage.jpegData(compressionQuality: 0.9) {
                let base64Image = imageData.base64EncodedString()
                let imageJSON = ["image": base64Image]
                let imageJSONData = try JSONSerialization.data(withJSONObject: imageJSON, options: [])
                jsonData += imageJSONData
            }

            request.httpBody = jsonData
        } catch {
            print("Error encoding information data: \(error.localizedDescription)")
            return
        }

        // Perform the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response and data as needed
            // ...
        }.resume()
    }
}

struct RadioGroup: View {
    @Binding var selectedOption: AddInfoView.Statement
    var options: [AddInfoView.Statement]

    var body: some View {
        ForEach(options, id: \.self) { option in
            RadioButton(text: option.rawValue, isSelected: option == selectedOption) {
                selectedOption = option
            }
            .padding(.trailing, 20)
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

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: UIImage?
        @Binding var isPresented: Bool
        
        init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
            _image = image
            _isPresented = isPresented
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = uiImage
            }
            
            isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
           let picker = UIImagePickerController()
           picker.delegate = context.coordinator
           picker.sourceType = .photoLibrary
           return picker
       }

       func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

   }

   struct AddInfoView_Previews: PreviewProvider {
       static var previews: some View {
           AddInfoView(information: nil)
       }
   }
