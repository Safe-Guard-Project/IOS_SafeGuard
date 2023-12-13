//
//  ProgramCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//
// ProgramCardView.swift

import SwiftUI

struct ProgramCardView: View {
    var program: Program
    

    var body: some View {
        VStack(alignment: .leading) {
      
            AsyncImage(url: URL(string: program.image)) { phase in
                                 switch phase {
                                 case .empty:
                                     ProgressView()
                                 case .success(let image):
                                     image
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(height: 150)
                                         .clipped()
                                 case .failure:
                                     Image(systemName: "Intro")
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(height: 150)
                                         .clipped()
                                 @unknown default:
                                     EmptyView()
                                 }
                             }


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
