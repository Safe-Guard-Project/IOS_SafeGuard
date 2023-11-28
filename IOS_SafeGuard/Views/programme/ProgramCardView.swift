//
//  ProgramCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//

import SwiftUI

struct ProgramCardView: View {
    var program : Program
    var body: some View {
       
        VStack(alignment: .leading, spacing: 8) {
            // Event image
            Image(program.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()

            // event details
            VStack(alignment: .leading, spacing: 8) {
                // Event title
                Text(program.Titre)
                    .font(.title)
                    .fontWeight(.medium)

                // Event description
                Text(program.descriptionProgramme)
                    .font(.body)
                    .foregroundColor(.secondary)

               
            }
            .padding(16)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(10)
    }
}


#Preview {
    ProgramCardView(program: Program(image: "Intro", Titre: "Tsunami", descriptionProgramme: "Decouvrir le phenomene"))
}
