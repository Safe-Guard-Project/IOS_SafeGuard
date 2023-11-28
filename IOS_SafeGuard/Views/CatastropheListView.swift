//
//  CatastropheListView.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import SwiftUI


struct CatastropheListView: View {
    var catastrophes: [Catastrophe]

    var body: some View {
        NavigationView {
            List(catastrophes, id: \.id) { catastrophe in
                NavigationLink(destination: CatastropheRow(catastrophe: catastrophe)) {
                    CatastropheRow(catastrophe: catastrophe)
                }
            }
            .navigationTitle("Catastrophes")
        }
    }
}

struct CatastropheListView_Previews: PreviewProvider {
    static var previews: some View {
        CatastropheListView(catastrophes: [
            Catastrophe(_id: "1", titre: "Sample 1", type: "Earthquake", tsunami: 1, description: "Sample Description 1", date: Date(), radius: 10.0, magnitude: 7.0, latitudeDeCatastrophe: 0.0, longitudeDeCatastrophe: 0.0, createdAt: Date(), updatedAt: Date()),
            Catastrophe(_id: "2", titre: "Sample 2", type: "Flood", tsunami: 0, description: "Sample Description 2", date: Date(), radius: 5.0, magnitude: 0.0, latitudeDeCatastrophe: 0.0, longitudeDeCatastrophe: 0.0, createdAt: Date(), updatedAt: Date())
        ])
    }
}
