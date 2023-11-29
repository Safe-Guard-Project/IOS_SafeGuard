//
//  ContenuView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct ContenuView: View {
    @State private var comment: String = ""
    let courses = [
        Cours(type:"Introduction", image:"Intro",description:"decouvrir le phenomene"),
        Cours(type:"Causes", image:"Intro",description:"decouvrir le phenomene"), 
        
    ]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(courses) { index in
                        ContenuCardView(cours: index)
                            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                            .background(Color(UIColor.systemBackground))
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Type")
                .navigationBarTitleDisplayMode(.large)

                HStack {
                    TextField("Ajouter un commentaire", text: $comment)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                        .padding([.leading, .bottom], 10)
                        .frame(height: 50)

                    Button(action: {
                        
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.blue)
                            .padding(.trailing, 10)
                    }
                }
                .background(Color(UIColor.systemBackground))
            }
        }
    }
}

#Preview {
    ContenuView()
}
