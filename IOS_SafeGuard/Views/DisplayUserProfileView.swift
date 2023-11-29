import Combine
import SwiftUI

struct DisplayUserProfileView: View {
    @StateObject private var displayProfileViewModel: DisplayUserProfileViewModel

    init(userId: String) {
        // Initialize the view model here
        self._displayProfileViewModel = StateObject(wrappedValue: DisplayUserProfileViewModel(userId: userId))
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
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()

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
                displayProfileViewModel.fetchUserInformation(userId: displayProfileViewModel.userId)
            }
            .navigationBarTitle("My Profile")
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        // You need to pass a userId when creating the instance
        DisplayUserProfileView(userId: "exampleUserId")
    }
}
