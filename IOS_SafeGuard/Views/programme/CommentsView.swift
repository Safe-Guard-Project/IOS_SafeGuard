import SwiftUI
struct CommentsView: View {
    @StateObject private var commentViewModel = CommentViewModel()

    var body: some View {
    
            List {
                ForEach(commentViewModel.comments) { comment in
                    CommentCardView(commentaire: comment)
                }
            }
            .navigationBarTitleDisplayMode(.large)
             // Titre de la barre de navigation

            .navigationBarItems(leading: HStack {
                Text("Tous les commentaires")
                    .font(.title2)
                    .foregroundColor(.secondary)
            })
        
        .onAppear {
            commentViewModel.getAllComments()
        }
    }
}
/*
import SwiftUI

struct CommentsView: View {
    var cours: Cours
    @ObservedObject var commentViewModel: CommentViewModel

    var body: some View {
        VStack {
            Text("Comments for \(cours.title)")
                .font(.title)
                .padding()

            List(commentViewModel.comments) { commentaire in
                Text(commentaire.textComment)
            }
            .onAppear {
                // Load comments when the view appears
                commentViewModel.getAllComments()
            }

            Spacer()
        }
        .navigationTitle("Comments")
    }
}*/

