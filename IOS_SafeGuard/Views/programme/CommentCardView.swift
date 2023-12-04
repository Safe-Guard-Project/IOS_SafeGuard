//
//  CommentCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CommentCardView: View {
    @StateObject private var commentViewModel = CommentViewModel()
    @State private var isDeleted: Bool = false

    var commentaire: Commentaire

    var body: some View {
        if !isDeleted {
            HStack {
                Text(commentaire.textComment)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
            }
            .cornerRadius(10)
            .padding(15)
            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
            .swipeActions(edge: .trailing) {
                Button("Modify") {
                    // Ajouter votre logique de modification ici
                }
                .tint(.blue)

                Button("Delete") {
                    commentViewModel.deleteComment(comment: commentaire)
                    isDeleted = true
                }
                .tint(.red)
            }
        }
    }
}
