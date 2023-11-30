import SwiftUI
import Combine
struct SplashScreenView: View {
    @State private var temporaryIsActive: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                self.temporaryIsActive = true
                            }
                        }
                    }

                if temporaryIsActive {
                    NavigationLink(
                        destination: HomePageView(),
                        isActive: $temporaryIsActive,
                        label: {
                            EmptyView()
                        }

                    )

                    .hidden()
                    
                }
            }
        }
    }
}
#Preview {
    SplashScreenView()
}
