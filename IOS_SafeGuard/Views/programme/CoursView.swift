import SwiftUI

struct CoursView: View {
    @StateObject private var viewModel = CoursViewModel()
    var program :Program

    var body: some View {
        NavigationView {
          
                VStack(spacing: 20) {
                    ForEach(Cours.CoursType.allCases, id: \.self) { type in
                        NavigationLink(destination: ContenuView(type: type , program: program)) {
                            CoursCardView(buttonText: type.rawValue)
                        }
                    }
                }
            
        }.navigationBarBackButtonHidden(true)
    }
}
