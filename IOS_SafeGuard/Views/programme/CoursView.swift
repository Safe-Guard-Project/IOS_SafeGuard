//
//  CoursView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CoursView: View {
   
    let courses = [
        Cours(type:"Introduction", image:"Intro",description:"decouvrir le phenomene"),
        Cours(type:"Causes", image:"Intro",description:"decouvrir le phenomene"), Cours(type:"Conséquences", image:"Intro",description:"decouvrir le phenomene"), Cours(type:"Signes", image:"Intro",description:"decouvrir le phenomene"),Cours(type:"Mesures de prespectives", image:"Intro",description:"decouvrir le phenomene"),
        
    ]

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                List {
                    ForEach(courses) { cours in
                        NavigationLink(destination: ContenuView()) {
                            CoursCardView(cours: cours)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
                .navigationBarTitle("Les differents partie de cours")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, 20 * geometry.size.height / 667)
            }
        }
    }
}

#Preview {
    CoursView()
}

