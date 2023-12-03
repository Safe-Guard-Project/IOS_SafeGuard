//
//  CoursCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CoursCardView : View {
    let buttonText: String

    var body: some View {
        VStack {
            Text(buttonText)
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
        }
    }
}
