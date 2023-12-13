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
