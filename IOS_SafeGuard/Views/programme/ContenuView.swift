import SwiftUI

struct ContenuView: View {
    @State private var comment: String = ""
    @StateObject private var viewModel = CoursViewModel()
    var type: Cours.CoursType

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.courses) { cours in
                    ContenuCardView(cours: cours)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                        .background(Color(UIColor.systemBackground))
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(type.rawValue)

                HStack {
                    TextField("Ajouter un commentaire", text: $comment)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                        .padding([.leading, .bottom], 10)
                        .frame(height: 50)

                    Button(action: {
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.blue)
                            .padding(.trailing, 10)
                    }
                }
                .background(Color(UIColor.systemBackground))
            }
            .onAppear {
              
                viewModel.fetchCoursesByType(type: type)
            }
        }
    }
}
