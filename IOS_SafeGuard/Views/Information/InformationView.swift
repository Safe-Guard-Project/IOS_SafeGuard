import SwiftUI

struct InformationView: View {
    let informations = [
        Information(titre: "Les forêts de Ain drahem en danger !!! ", typeCatastrophe: "Incendie", pays: "Tunisie", region: "Ain Drahem", descriptionInformation: "Une Incendie a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: Date(), image: "thumbnail-incendie-herve-dermoune", pourcentageFiabilite: 100, etat: "On going"),
        Information(titre: "Tsunami menace l'europe !!! ", typeCatastrophe: "Tsunami", pays: "France", region: "Nice", descriptionInformation: "Une alerte de Tsunami a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: Date(), image: "doc2", pourcentageFiabilite: 70, etat: "Coming")
        
        
    ]

    @State private var isActionButtonVisible = false
    @State private var isAddInfoViewActive = false

    var body: some View {
        NavigationView {
            List {
                ForEach(informations) { information in
                    NavigationLink(destination: DetailsInfoView(information: information)) {
                        InformationCardView(information: information)
                            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                    }
                }
            }
            .navigationTitle("Informations")
            .navigationBarTitleDisplayMode(.large)
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddInfoView(information: Information(titre: "jjj", typeCatastrophe: "gggg", pays: "ggg", region: "ggg", descriptionInformation: "fff", dateDePrevention: Date(), image: "intro", pourcentageFiabilite: 50, etat: "NOT YET"))) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 5)
                        .padding()
                    }
                }
                .padding()
                .opacity(isActionButtonVisible ? 1 : 0)
                , alignment: .bottomTrailing
            )
            .onAppear {
                withAnimation {
                    isActionButtonVisible = true
                }
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
