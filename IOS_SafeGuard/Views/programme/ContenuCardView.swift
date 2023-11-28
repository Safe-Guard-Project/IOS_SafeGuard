//
//  ContenuCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct ContenuCardView: View {
    var cours : Cours
    var body: some View {
       
        VStack(alignment: .leading, spacing: 8) {
           
            GeometryReader { geometry in
                            Image(cours.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width - 80, height: 200) 
                                .clipped()
                                .cornerRadius(10)
                                .offset(x: 40, y: 10)
                        }
                        .frame(height: 200)
                Text(cours.description)
                    .font(.body)
                
            .padding(16)
        }

    }
}

#Preview {
    ContenuCardView(cours: Cours(type: "Cause", image: "Intro", description: "ok"))
}
