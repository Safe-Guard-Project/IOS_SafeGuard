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
