import SwiftUI

struct HomePageView: View {
    var body: some View {
        TabView {
            ProgramView()
                .tabItem {
                    Label("Learn", systemImage: "plus.circle.fill")
                        .foregroundColor(.black)
                }

            ContentViewCatastrophe()
                .tabItem {
                    Label("Catastrophe", systemImage: "globe")
                        .foregroundColor(.black)
                }

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                        .foregroundColor(.black)
                }

            DisplayUserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                        .foregroundColor(.black)
                }
            
            InformationView()
                .tabItem {
                    Label("Blog", systemImage: "exclamationmark.bubble")
                        .foregroundColor(.black)
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .toolbarBackground(Color(red: 255, green: 255, blue: 255), for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
}

#if targetEnvironment(simulator)
struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
#endif
