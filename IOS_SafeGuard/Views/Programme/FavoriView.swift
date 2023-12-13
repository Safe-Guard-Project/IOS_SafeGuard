
import SwiftUI


struct FavoriView: View {
    @StateObject private var favorieViewModel = FavorieViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(favorieViewModel.favories) { favori in
                    FavoriCardView(favorie: favori )
                        
                }
               
            }
            .navigationTitle("Votre Favoris")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            favorieViewModel.getAllFav()
        }
    }

   /* private func deleteComment(at indexSet: IndexSet) {
        commentViewModel.comments.remove(atOffsets: indexSet)
    }*/
}
