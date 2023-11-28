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
        Cours(type:"Causes", image:"Intro",description:"decouvrir le phenomene"), Cours(type:"Conséquences", image:"Intro",description:"decouvrir le phenomene"), Cours(type:"Signes", image:"Intro",description:"decouvrir le phenomene"),
        
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(courses) { index in
               
                    CoursCardView(cours: index)
                        .listRowInsets(EdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 4))
                }
            }
            .navigationTitle("Les differents partie de cours").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CoursView()
}
