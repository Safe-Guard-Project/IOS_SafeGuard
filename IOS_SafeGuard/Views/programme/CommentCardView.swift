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
                Button("Delete", systemImage: "trash") {
                    commentViewModel.deleteComment(comment: commentaire)
                    isDeleted = true
                }
                .tint(.red)
                
                Button("Modify", systemImage: "pencil") {
                
                }
                .tint(.blue)


            }
        }
    }
}/*
import SwiftUI

struct CommentCardView: View {
    @StateObject private var commentViewModel = CommentViewModel()
    @State private var isDeleted: Bool = false
    @State private var isContenuCardViewPresented = false

    var commentaire: Commentaire

    var body: some View {
        NavigationLink(destination: ContenuCardView(cours: <#Cours#>, commentViewModel: 
                                                        nil, favViewModel: nil), isActive: $isContenuCardViewPresented) {
            EmptyView()
        }
        .hidden() // Caché, car nous utilisons le lien de navigation de manière programmatique

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
                Button("Delete", systemImage: "trash") {
                    commentViewModel.deleteComment(comment: commentaire)
                    isDeleted = true
                }
                .tint(.red)
                
                Button("Modify", systemImage: "pencil") {
                    // Activer la navigation vers ContenuCardView
                    isContenuCardViewPresented.toggle()
                }
                .tint(.blue)
            }
        }
    }
}
*/
