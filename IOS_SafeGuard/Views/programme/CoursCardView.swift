//
//  CoursCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CoursCardView: View {
    var cours : Cours
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
                Text(cours.type)
                    .font(.title)
                    .fontWeight(.medium)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(15)
       
    }
}

#Preview {
    CoursCardView(cours: Cours(type: "Cause", image: "Intro", description: "ok"))
}
