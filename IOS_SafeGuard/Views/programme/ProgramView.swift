//
//  ProgramView.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//
import SwiftUI

struct ProgramView: View {
    @ObservedObject var viewModel = ProgramViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.programs) { program in
                ProgramCardView(program: program)
               /* NavigationLink(destination: CoursView()) {
                    ProgramCardView(program: program)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                }*/
            }
            .onAppear {
                viewModel.getAllPrograms()
            }
            .navigationTitle("Programmes")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
