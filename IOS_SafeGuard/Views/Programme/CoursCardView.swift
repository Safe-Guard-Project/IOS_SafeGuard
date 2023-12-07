//
//  CoursCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//
import SwiftUI

struct CoursCardView: View {

    let buttonText: String

    var body: some View {

        VStack {

            Text(buttonText)

                .font(.headline)

                .foregroundColor(.white)

                .frame(width: 200, height: 40)

                .padding()

                .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))

                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 2))

                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3) // Add a shadow
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)

        }

    }

}
