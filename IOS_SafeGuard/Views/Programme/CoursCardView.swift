//
//  CoursCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CoursCardView: View {
    var cours: Cours

       var body: some View {
           VStack {
               Text(cours.type)
                   .font(.title)
                   .fontWeight(.medium)
                   .foregroundColor(.white)
                   .padding(10)
                   .background(Color.blue)
                   .cornerRadius(10)
           }
           .frame(maxWidth: .infinity, alignment: .center)
           .background(Color.blue)
           .cornerRadius(10)
           .padding(15)
       }
}

#Preview {
    CoursCardView(cours: Cours(type: "Cause", image: "Intro", description: "ok"))
}
