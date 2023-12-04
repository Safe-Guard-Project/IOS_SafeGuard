//
//  ContenuCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//


import SwiftUI

struct ContenuCardView: View {
    var cours: Cours
    @State private var comment: String = ""
     @State private var isFavorite: Bool = false
      @ObservedObject var commentViewModel: CommentViewModel
    @ObservedObject var favViewModel: FavorieViewModel
  

     var body: some View {
         VStack(alignment: .leading, spacing: 8) {
             HStack {
                 Spacer()
                 Button(action: {
                     isFavorite.toggle()

                     if isFavorite {
                         favViewModel.addFav(idCoursProgramme: cours.id)
                         
                        
                     } else {
                         
                     }
                 }) {
                     Image(systemName: isFavorite ? "heart.fill" : "heart")
                         .foregroundColor(isFavorite ? Color.blue : Color.gray)
                         .padding(.top, 8)
                 }
                 .padding(.trailing, 8)
                 .font(.title)
             }

             GeometryReader { geometry in
                 Image(cours.image)
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: geometry.size.width - 80, height: 200)
                     .clipped()
                     .cornerRadius(10)
                     .offset(x: 40, y: 10)
             }
             .frame(height: 200)
             Text(cours.description)
                 .font(.body)
                 .padding(16)
         }
         .background(Color.white)
         .cornerRadius(10)
         .padding(10)
         HStack {
                         TextField("Ajouter un commentaire", text: $comment)
                             .padding(10)
                             .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                             .padding([.leading, .bottom], 10)
                             .frame(height: 50)

                         Button(action: {
                             commentViewModel.addComment(textComment: comment, idCoursProgramme: cours.id)
                             comment = ""
                         }) {
                             Image(systemName: "arrow.right.circle.fill")
                                 .resizable()
                                 .frame(width: 30, height: 30)
                                 .foregroundColor(Color.blue)
                                 .padding(.trailing, 10)
                         }
                     }
                     .background(Color(UIColor.systemBackground))
     }
}/*
import SwiftUI

struct ContenuCardView: View {
    var cours: Cours
    @State private var comment: String = ""
    @State private var isFavorite: Bool = false
    @ObservedObject var commentViewModel: CommentViewModel
    @ObservedObject var favViewModel: FavorieViewModel
    @State private var isCommentaireListViewActive: Bool = false

    var body: some View {
        NavigationLink(
            destination: CommentaireListView(cours: cours, commentViewModel: commentViewModel),
            isActive: $isCommentaireListViewActive
        ) {
            EmptyView()
        }
        .hidden()

        VStack(alignment: .leading, spacing: 8) {
            // ... Your existing content

            HStack {
                TextField("Ajouter un commentaire", text: $comment)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                    .padding([.leading, .bottom], 10)
                    .frame(height: 50)

                Button(action: {
                    commentViewModel.addComment(textComment: comment, idCoursProgramme: cours.id)
                    comment = ""
                    isCommentaireListViewActive.toggle()
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.blue)
                        .padding(.trailing, 10)
                }
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}
*/
