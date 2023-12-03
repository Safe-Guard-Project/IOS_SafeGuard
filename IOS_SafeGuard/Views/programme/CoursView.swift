//
//  CoursView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CoursView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
               /* CoursCardView(buttonText: "Introduction")
                CoursCardView(buttonText: "Cause")
                CoursCardView(buttonText: "Consequence")
                CoursCardView(buttonText: "Agir")
                CoursCardView(buttonText: "Signe")
                */
                NavigationLink(destination: ContenuView())  {
                    CoursCardView(buttonText: "Introduction")
                }

                NavigationLink(destination: ContenuView()) {
                    CoursCardView(buttonText: "Cause")
                }

                NavigationLink(destination: ContenuView()) {
                    CoursCardView(buttonText: "Consequence")
                }

                NavigationLink(destination: ContenuView()) {
                    CoursCardView(buttonText: "Agir")
                }

                NavigationLink(destination: ContenuView()) {
                    CoursCardView(buttonText: "Signe")
                }
                 
            }
            
        }
    }
}
