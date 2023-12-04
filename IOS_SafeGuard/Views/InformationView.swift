// InformationView.swift
import SwiftUI

struct InformationView: View {
    @ObservedObject var viewModel = InformationViewModel()

    var body: some View {
        NavigationView {
            List ( viewModel.informations) { Information in
                NavigationLink (destination: DetailsInfoView(information: Information)) {
                    InformationCardView(information: Information)
                        .listRowInsets(EdgeInsets(top:2 , leading:5 , bottom:4, trailing:4))
                }
            }
    
            .onAppear {
                viewModel.getAllInformation()
            }
            .navigationTitle("Informations")
            .navigationBarTitleDisplayMode(.large)
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddInfoView(information: nil)) {
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
            , alignment: .bottomTrailing)
        }
    }
}
