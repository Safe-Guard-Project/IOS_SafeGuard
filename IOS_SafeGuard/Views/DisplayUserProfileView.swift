import SwiftUI

struct DisplayUserProfileView: View {
    @StateObject private var displayProfileViewModel: DisplayUserProfileViewModel

    init() {
        // Initialize the view model with the userRepository parameter
        let apiService: APIService = ApiManager.shared // Adjust this based on your implementation
        let webServiceProvider: WebServiceProvider = WebServiceProvider.shared // Adjust this based on your implementation
        let userRepository = UserRepositoryImpl(apiService: apiService, webServiceProvider: webServiceProvider)
        self._displayProfileViewModel = StateObject(wrappedValue: DisplayUserProfileViewModel(userRepository: userRepository))
    }

    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading, spacing: 8) {
                    VStack {
                        GeometryReader { geometry in
                            Image("Person")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width, height: 100)
                                .padding(.bottom, 8)
                        }
                    }

                    HStack {
                        Text(displayProfileViewModel.userName)
                            .font(.headline)
                            .padding(.leading, 100)
                    }

                    HStack {
                        Text(displayProfileViewModel.userEmail)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading, 100)
                    }

                    HStack {
                        Text(displayProfileViewModel.userPhoneNumber)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading, 100)
                    }
                }
                .padding(8)
            }
            .onAppear {
                // Fetch user information when the view appears
                displayProfileViewModel.fetchUserInformation()
            }
            .navigationBarTitle("My Profile")

            VStack(spacing: 20) {
                NavigationLink(destination: CommentsView()) {
                    Text("Go to Comment")
                }

                NavigationLink(destination:FavoriView()) {
                    Text("Go to List Favoris")
                }
            }
        }
    }
}

struct DisplayUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayUserProfileView()
    }
}
