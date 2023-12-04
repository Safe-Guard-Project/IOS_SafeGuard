
import SwiftUI

struct ContenuView: View {
    @StateObject private var viewModel = CoursViewModel()
    @StateObject private var commentViewModel = CommentViewModel() 
    @StateObject private var favorieViewModel = FavorieViewModel() // Ajout du CommentViewModel
    var type: Cours.CoursType

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.courses) { cours in
                    ContenuCardView(cours: cours, commentViewModel: commentViewModel, favViewModel: favorieViewModel)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                        .background(Color(UIColor.systemBackground))
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(type.rawValue)
            }
            .onAppear {
                viewModel.fetchCoursesByType(type: type)
            }
        }
    }
}

