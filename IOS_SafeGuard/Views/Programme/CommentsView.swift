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
