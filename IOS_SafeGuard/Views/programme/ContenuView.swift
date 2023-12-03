import SwiftUI

struct ContenuView: View {
    @State private var comment: String = ""
    @StateObject private var viewModel = CoursViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.courses) { cours in
                    ContenuCardView(cours: cours)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                        .background(Color(UIColor.systemBackground))
                }
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.large)

                HStack {
                    TextField("Ajouter un commentaire", text: $comment)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.2)))
                        .padding([.leading, .bottom], 10)
                        .frame(height: 50)

                    Button(action: {
                        // Add your button action logic here
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
                // Fetch courses when the view appears
                viewModel.fetchCoursesByType(type: .CAUSE)
            }
        }
    }
}

struct ContenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContenuView()
    }
}
