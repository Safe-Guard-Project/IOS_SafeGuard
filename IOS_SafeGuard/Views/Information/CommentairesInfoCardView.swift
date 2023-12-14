//
//  CommentairesInfoCardView.swift
//  IOS_SafeGuard
//
//  Created by EkbelZrelli on 13/12/2023.
//


import SwiftUI

struct CommentairesInfoCardView: View {
    @StateObject private var commentInfoViewModel = CommentInfoViewModel()
    @State private var isDeleted: Bool = false

    var commentaire: CommentaireInfo

    var body: some View {
        if !isDeleted {
            HStack {
                Text(commentaire.descriptionCommentaire)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
            }
            .cornerRadius(10)
            .padding(15)
            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
            .swipeActions(edge: .trailing) {
                Button("Delete", systemImage: "trash") {
                    commentInfoViewModel.deleteComment(comment: commentaire)
                    isDeleted = true
                }
                .tint(.red)
              


            }
        }
    }
}
