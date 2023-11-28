import SwiftUI

struct AddInfoView: View {
    var information: Information

    @State private var title = ""
    @State private var typeOfCatastrophe = "Earthquake" // Valeur par défaut
    @State private var country = ""
    @State private var region = ""
    @State private var selectedDate = Date()
    @State private var isOngoing = true
    @State private var liabilityPercentage = ""
    @State private var selectedImage: Image?
    @State private var descriptionCatastrophe = ""

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
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("Statement")
                        HStack {
                            RadioGroup(selectedOption: $statement, options: [.ongoing, .notYet])
                        }
                    }
                    
                    TextField("Liability Percentage", text: $liabilityPercentage)
                        .keyboardType(.decimalPad) // Autoriser uniquement les caractères numériques
                    VStack(alignment: .leading) {
                        TextField("Description of Catastrophe", text:$descriptionCatastrophe)
                            .frame(height: 100)
                    }
                    
                    
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                // Add logic to select or capture an image
                                // You can use ImagePicker or Camera capture logic here
                            }) {
                                Image(systemName: "camera")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            Spacer()
                        }
                    }
                    
                }

                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Ajouter la logique pour envoyer les données du formulaire
                            print("Send button tapped")
                            // Vous pouvez utiliser les données saisies ici, par exemple, les enregistrer dans votre modèle
                            let newInformation = Information(
                                titre: title,
                                typeCatastrophe: typeOfCatastrophe,
                                pays: country,
                                region: region,
                                descriptionInformation: descriptionCatastrophe,
                                dateDePrevention: selectedDate.description,
                                image: "", // Vous devez gérer la logique de l'image ici
                                pourcentageFiabilite: Double(liabilityPercentage) ?? 0,
                                etat: statement.rawValue
                            )

                            // Vous pouvez maintenant utiliser newInformation selon vos besoins
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

struct AddInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AddInfoView(information: Information(titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation", pays: "France", region: "Nice", descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: "22-5-2023", image: "intro", pourcentageFiabilite: 50, etat: "Coming"))
    }
}
