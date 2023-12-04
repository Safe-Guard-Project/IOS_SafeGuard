import SwiftUI

struct AddInfoView: View {
    var information: Information?

    @State private var title = ""
    @State private var typeOfCatastrophe = "Earthquake" // Default value
    @State private var country = ""
    @State private var region = ""
    @State private var selectedDate = Date()
    @State private var liabilityPercentage = ""
    @State private var descriptionCatastrophe = ""
    @State private var statement: Statement = .ongoing

    enum Statement: String {
        case ongoing = "Ongoing"
        case notYet = "Not Yet"
    }

    @ObservedObject private var viewModel = InformationViewModel()

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
                        RadioGroup(selectedOption: $statement, options: [.ongoing, .notYet])
                    }

                    TextField("Liability Percentage", text: $liabilityPercentage)
                        .keyboardType(.decimalPad) // Allow only numeric input
                    VStack(alignment: .leading) {
                        TextField("Description of Catastrophe", text: $descriptionCatastrophe)
                            .frame(height: 100)
                    }
                }

                Section {
                    // Removed image-related code
                }

                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Send button tapped")

                            let newInformation = Information(
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

                            viewModel.sendInformationToServer(newInformation)

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
}
