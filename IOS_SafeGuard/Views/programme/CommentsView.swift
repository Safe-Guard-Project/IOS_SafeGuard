import SwiftUI

struct CommentsView: View {
    /*
     let comments = [
     "Great information!",
     "Very helpful.",
     "I have a question...",
     "Nice explanation!",
     "Thank you!"
     // Add more comments as needed
     ]
     */
    @State private var comments: [Commentaire] = [
           Commentaire(textComment: "Great information!"),
           Commentaire(textComment: "I have a question"),
           Commentaire(textComment: "Nice explanation!"),
           Commentaire(textComment: "Thank you!"),
       ]
    var body: some View {
        NavigationView {
            List {
                ForEach(comments) { comment in
                    CommentCardView(commentaire: comment)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                        .swipeActions {
                            Button("Modify") {
                                // Add code for modifying the comment
                            }
                            .tint(.blue)
                            
                            Button("Delete") {
                                // Add code for deleting the comment
                                if let index = comments.firstIndex(where: { $0.id == comment.id }) {
                                    comments.remove(at: index)
                                }
                            }
                            .tint(.red)
                        }
                }
                .onDelete(perform: deleteComment)
            }
            .navigationTitle("Votre avis")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func deleteComment(at indexSet: IndexSet) {
        comments.remove(atOffsets: indexSet)
    }
}

#Preview {
    CommentsView()
}
