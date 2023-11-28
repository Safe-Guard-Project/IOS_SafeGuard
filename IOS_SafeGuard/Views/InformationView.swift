import SwiftUI

struct InformationView: View {
    let informations = [
        Information(titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation", pays: "France", region: "Nice", descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: "22-5-2023", image: "intro", pourcentageFiabilite: 50, etat: "Coming"),
        Information(titre: "Une inondation au bout de 3 heures !!! ", typeCatastrophe: "inondation", pays: "France", region: "Nice", descriptionInformation: "Une alerte d'inondation a été émise pour la région en raison des fortes précipitations attendues au cours des prochaines heures", dateDePrevention: "22-5-2023", image: "intro", pourcentageFiabilite: 50, etat: "Coming")
    ]

    @State private var isActionButtonVisible = false
    @State private var isAddInfoViewActive = false

    var body: some View {
        NavigationView {
            List {
                ForEach(informations) { index in
                    InformationCardView(information: index)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                }
            }
            .navigationTitle("Informations")
            .navigationBarTitleDisplayMode(.large)
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddInfoView(information: Information(titre:"jjj", typeCatastrophe: "gggg", pays: "ggg", region: "ggg", descriptionInformation:"fff" , dateDePrevention: "22-12-2011", image: "intro", pourcentageFiabilite: 50, etat: "NOT YET")))  { // Pass an instance of Information
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
