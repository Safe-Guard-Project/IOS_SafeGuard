//
//  CatastropheRow.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import SwiftUI

struct CatastropheRow: View {
    var catastrophe: Catastrophe

    var body: some View {
        HStack {
            Image("Earthquake")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(15)

            VStack(alignment: .leading, spacing: 5) {
                Text("Type: \(catastrophe.type)")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("Description: \(catastrophe.description)")
                    .font(.subheadline)
                Text("Magnitude: \(catastrophe.magnitude) Richter")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding([.leading, .trailing], 10)
        .padding([.top, .bottom], 5)
    }
}
/*
struct CatastropheRow_Previews: PreviewProvider {
    static var previews: some View {
        CatastropheRow(catastrophe: Catastrophe(_id: "1", titre: "Sample", type: "Earthquake", tsunami: 1, description: "Sample Description", date: Date(), radius: 10.0, magnitude: 7.0, latitudeDeCatastrophe: 0.0, longitudeDeCatastrophe: 0.0, createdAt: Date(), updatedAt: Date()))
    }
}
*/
