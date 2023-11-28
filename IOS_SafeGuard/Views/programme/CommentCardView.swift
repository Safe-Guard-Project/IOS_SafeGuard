//
//  CommentCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CommentCardView: View {
    var commentaire : Commentaire
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
                   
                    
            Text(commentaire.textComment)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                }
        .frame(maxWidth: .infinity, alignment: .center)
        .cornerRadius(10)
        .padding(15)
    }
}

#Preview {
    CommentCardView(commentaire: Commentaire(textComment: "J'ai trop aimé "))
}
