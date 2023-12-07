//
//  ProgramCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//

import SwiftUI

struct ProgramCardView: View {
    var program: Program

    var body: some View {
        VStack(alignment: .leading) {
            /*AsyncImage(url: URL(string: program.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 200)
                    .clipped()
            } placeholder: {
                // Placeholder view while the image is loading
                ProgressView()
            }*/
            
            /*AsyncImage(url: URL(string: "http://localhost:9090/\(program.image)")) { phase in
                                 switch phase {
                                 case .empty:
                                     ProgressView()
                                 case .success(let image):
                                     image
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(height: 200)
                                         .clipped()
                                 case .failure:
                                     Image(systemName: "Intro") // You can use a placeholder image here
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(height: 200)
                                         .clipped()
                                 @unknown default:
                                     EmptyView()
                                 }
                             }*/
            GeometryReader { geometry in
                Image("tsunami")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width - 80, height: 200)
                    .clipped()
                    .cornerRadius(10)
                    .offset(x: 40, y: 10)
            }
            .frame(height: 200)

            VStack(alignment: .leading) {
                Text(program.Titre)
                    .font(.system(size: 20))
                    .fontWeight(.medium)

                Text(program.descriptionProgramme)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(16)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

