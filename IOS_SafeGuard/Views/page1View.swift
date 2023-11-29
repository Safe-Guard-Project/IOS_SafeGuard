import SwiftUI

struct Page1View: View {
    var body: some View {
        NavigationView {
            VStack {
              

                NavigationLink(destination: InformationView()) {
                    Text("Go to Information ")
                }
                .padding()

                NavigationLink(destination: ProfileView()) {
                    Text("Go to Profile ")
                }
                .padding()
            }
            .navigationTitle("Page 1")
        }
    }
}

struct Page1View_Previews: PreviewProvider {
    static var previews: some View {
        Page1View()
    }
}
