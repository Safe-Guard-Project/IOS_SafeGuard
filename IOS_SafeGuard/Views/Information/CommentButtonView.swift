//
//  CommentButtonView.swift
//  IOS_SafeGuard
//
//  Created by EkbelZrelli on 13/12/2023.
//

import SwiftUI




struct CommentButtonView: View {
    @StateObject private var commentInfoViewModel = CommentInfoViewModel()

    var body: some View {
        NavigationView{
            
            NavigationLink(destination: CommentairesInfoView()) {
                HStack(spacing: 5) {
                    Image(systemName: "bubble.left")
                    Text("Commentaires")
                }
                .padding(8)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
        }}
}
