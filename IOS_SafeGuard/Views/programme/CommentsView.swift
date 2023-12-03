import SwiftUI
struct CommentsView: View {
    @StateObject private var commentViewModel = CommentViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(commentViewModel.comments) { comment in
                    CommentCardView(commentaire: comment)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                        .swipeActions {
                            Button("Modify") {
                               
                            }
                            .tint(.blue)

                            Button("Delete") {
                             
                                commentViewModel.deleteComment(comment: comment)
                            }
                            .tint(.red)
                        }
                }
                .onDelete(perform: deleteComment)
            }
            .navigationTitle("Votre avis")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            commentViewModel.getAllComments()
        }
    }

    private func deleteComment(at indexSet: IndexSet) {
        commentViewModel.comments.remove(atOffsets: indexSet)
    }
}
