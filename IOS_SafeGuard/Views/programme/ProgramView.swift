//
//  ProgramView.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//

import SwiftUI

struct ProgramView: View {
    let programs = [
        Program(image:"Intro",Titre:"Tsunami",descriptionProgramme:"decouvrir le phenomene"),
        Program(image:"Intro",Titre:"Tsunami",descriptionProgramme:"decouvrir le phenomene"),
       

    ]

    
    var body: some View {
        
       
        NavigationView {
           
            List {
             
                ForEach(programs) { index in
                    
               
                    ProgramCardView(program: index)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                }
            }
            .navigationTitle("Programmes").navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProgramView()
}
