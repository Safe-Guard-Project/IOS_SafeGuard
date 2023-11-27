import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = false
    @State private var temporaryIsActive: Bool? = nil

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

                NavigationLink(
                    destination: SignInView(),
                    tag: true,
                    selection: $temporaryIsActive,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
                .id("SplashScreenViewLink") // Add an identifier to the link
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
