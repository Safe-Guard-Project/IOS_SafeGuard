//
//  CommentairesInfoView.swift
//  IOS_SafeGuard
//
//  Created by EkbelZrelli on 13/12/2023.
//


import SwiftUI
struct CommentairesInfoView: View {
    @StateObject private var commentInfoViewModel = CommentInfoViewModel()

    var body: some View {
    
            List {
                ForEach(commentInfoViewModel.comments) { comment in
                    CommentairesInfoCardView(commentaire: comment)
                }
            }
            .navigationBarTitleDisplayMode(.large)
             
            .navigationBarItems(leading: HStack {
                Text("Liste des commentaires")
                    .font(.title2)
                    .foregroundColor(.secondary)
            })
        
        .onAppear {
            commentInfoViewModel.getAllComments()
        }
    }
}
