//
//  CommentairesInfoCardView1.swift
//  IOS_SafeGuard
//
//  Created by EkbelZrelli on 14/12/2023.
//

import SwiftUI

struct CommentairesInfoCardView1: View {
    @StateObject private var commentInfoViewModel = CommentInfoViewModel()

    var commentaire: CommentaireInfo

    var body: some View {
   
            HStack {
                Text(commentaire.descriptionCommentaire)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
            }
            .cornerRadius(10)
            .padding(15)
            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
           

      
    }
}
