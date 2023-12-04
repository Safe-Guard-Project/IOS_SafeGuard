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
