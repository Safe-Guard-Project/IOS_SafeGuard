//
//  ContenuCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//
/*
import SwiftUI

struct ContenuCardView: View {
    var cours: Cours
     @State private var isFavorite: Bool = false

     var body: some View {
         VStack(alignment: .leading, spacing: 8) {
             HStack {
                 Spacer()
                 Button(action: {
                     isFavorite.toggle()

                     if isFavorite {
                        
                     } else {
                         
                     }
                 }) {
                     Image(systemName: isFavorite ? "heart.fill" : "heart")
                         .foregroundColor(isFavorite ? Color.blue : Color.gray)
                         .padding(.top, 8)
                 }
                 .padding(.trailing, 8)
                 .font(.title)
             }

             // Image
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
         .background(Color.white)
         .cornerRadius(10)
        
         .padding(10)
     }
}
#Preview {
    ContenuCardView(cours: Cours(type: .CAUSE, image: "Intro", description: "ok"))
 } */
/*
import SwiftUI

struct ContenuCardView: View {
    var cours: Cours
     @State private var isFavorite: Bool = false

     var body: some View {
         VStack(alignment: .leading, spacing: 8) {
             HStack {
                 Spacer()
                 Button(action: {
                     isFavorite.toggle()

                     if isFavorite {
                        
                     } else {
                         
                     }
                 }) {
                     Image(systemName: isFavorite ? "heart.fill" : "heart")
                         .foregroundColor(isFavorite ? Color.blue : Color.gray)
                         .padding(.top, 8)
                 }
                 .padding(.trailing, 8)
                 .font(.title)
             }

             // Image
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
         .background(Color.white)
         .cornerRadius(10)
        
         .padding(10)
     }
}

#Preview {
    ContenuCardView(cours: Cours(type: "Cause", image: "Intro", description: "ok"))
}
*/
