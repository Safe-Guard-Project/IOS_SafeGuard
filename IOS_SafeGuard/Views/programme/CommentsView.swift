import SwiftUI
struct CommentsView: View {
    @StateObject private var commentViewModel = CommentViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(commentViewModel.comments) { comment in
                    CommentCardView(commentaire: comment)
                        
                }
               
            }
            .navigationTitle("Votre avis")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            commentViewModel.getAllComments()
        }
    }

   /* private func deleteComment(at indexSet: IndexSet) {
        commentViewModel.comments.remove(atOffsets: indexSet)
    }*/
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

