import SwiftUI
struct ContenuView: View {
    @StateObject private var viewModel = CoursViewModel()
    @StateObject private var commentViewModel = CommentViewModel()
    @StateObject private var favorieViewModel = FavorieViewModel()
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
                .navigationBarItems(trailing:
                    NavigationLink(destination: CommentsView()) {
                        Image(systemName: "text.bubble")
                            .imageScale(.large)
                            .padding()
                    }
                )
            }
            .onAppear {
                viewModel.fetchCoursesByType(type: type)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
    }
}
