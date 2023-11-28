//
//  ProgramView.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//
import SwiftUI

struct ProgramView: View {
    let programs = [
        Program(image: "Intro", Titre: "Tsunami", descriptionProgramme: "Découvrir le phénomène"),
        Program(image: "Intro", Titre: "Tsunami", descriptionProgramme: "Découvrir le phénomène"),
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(programs) { program in
                    NavigationLink(destination: CoursView()) { // Navigate to CoursView when tapped
                        ProgramCardView(program: program)
                            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                    }
                }
            }
            .navigationTitle("Programmes")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProgramView()
}
