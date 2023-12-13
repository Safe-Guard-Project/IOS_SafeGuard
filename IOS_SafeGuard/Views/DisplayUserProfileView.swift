import SwiftUI

struct DisplayUserProfileView: View {
    
    let defaults = UserDefaults.standard
    
    private var username: String {
        UserDefaults.standard.string(forKey: "UserName") ?? ""
    }
    
    private var email: String {
        UserDefaults.standard.string(forKey: "email") ?? ""
    }
    
    private var phoneNumber: String {
        UserDefaults.standard.string(forKey: "numeroTel") ?? ""
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
                                .padding(.bottom, 50)
                        }
                    }

                    Text("Username:")
                        .font(.headline)
                        .padding(.leading, 16)
                    Text(username)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 16)

                    Text("Email:")
                        .font(.headline)
                        .padding(.leading, 16)
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 16)

                    Text("Phone Number:")
                        .font(.headline)
                        .padding(.leading, 16)
                    Text(phoneNumber)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                    
                    // Add NavigationLink to FavoriView
                    NavigationLink(destination: FavoriView()) {
                        Text("Your Favorites")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.leading, 16)
                    }
                }
                .padding(8)
            }
            .onAppear {
                // Fetch user information when the view appears
            }
            
            .navigationBarTitle("My Profile")
            //.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .background(Color("BlueBackground"))
        }
    }
}

struct DisplayUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayUserProfileView()
    }
}
