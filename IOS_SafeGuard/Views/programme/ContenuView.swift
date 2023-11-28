//
//  ContenuView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct ContenuView: View {
    let courses = [
        Cours(type:"Introduction", image:"Intro",description:"decouvrir le phenomene"),
        Cours(type:"Causes", image:"Intro",description:"decouvrir le phenomene"), Cours(type:"Conséquences", image:"Intro",description:"decouvrir le phenomene"), Cours(type:"Signes", image:"Intro",description:"decouvrir le phenomene"),Cours(type:"Mesures de prespectives", image:"Intro",description:"decouvrir le phenomene"),
        
    ]

    
    var body: some View {
           NavigationView {
               List {
                   ForEach(courses) { index in
                       ContenuCardView(cours: index)
                           .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                           .background(Color(UIColor.systemBackground)) // Utilise la couleur de fond de l'interface
                   }
               }
               .listStyle(PlainListStyle())
               .navigationTitle("Type")
               .navigationBarTitleDisplayMode(.large)
           }
       }

}

#Preview {
    ContenuView()
}
