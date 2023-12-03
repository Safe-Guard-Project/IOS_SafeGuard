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
            AsyncImage(url: URL(string: program.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 200)
                    .clipped()
            } placeholder: {
                // Placeholder view while the image is loading
                ProgressView()
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
