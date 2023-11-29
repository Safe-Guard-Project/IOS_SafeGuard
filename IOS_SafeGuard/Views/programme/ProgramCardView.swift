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
            VStack(alignment: .leading) {
                Image(program.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 200) 
                    .clipped()
           

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


#Preview {
    ProgramCardView(program: Program(image: "tsunami", Titre: "Tsunami", descriptionProgramme: "Decouvrir le phenomene"))
}
