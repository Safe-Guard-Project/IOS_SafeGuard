import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isActive: Bool = false // Track navigation state
    @State private var isLoginFailed: Bool = false // Track navigation state
    @State private var isDisplayActive: Bool = false
    @StateObject private var signInViewModel = SignInViewModel()

    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Image("Image1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.leading, 280)
                }
                Text("Sign In")
                    .font(.largeTitle)
                    .padding(.leading, 40)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Spacer()
                    Button(action: {
                        
                        isDisplayActive.toggle()
            
                    }) {
                        NavigationLink(destination:DisplayUserProfileView(),isActive:$isDisplayActive,label:{
                            Text("Sign in")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 243, height: 51)
                                .background(Color(red: 0, green: 0.28, blue: 1))
                                .cornerRadius(50)
                        }
                    )}
                    .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default button style
                    .disabled($signInViewModel.isSigningIn.wrappedValue)
                    Spacer()
                }

                if isLoginFailed {
                    Text("Incorrect email or password. Please try again.")
                        .foregroundColor(.red)
                        .padding()
                }

                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                        .padding()

                    // Use the navigationDestination modifier to navigate to the next view
                    NavigationLink(
                        destination: SignUpView(),
                        isActive: $isActive,
                        label: {
                            Text("Sign Up")
                                .padding()
                        }
                    )
                    VStack(spacing: 20) {
                                        NavigationLink(destination: CommentsView()) {
                                            Text("Go to Comment")
                                        }

                                        NavigationLink(destination:FavoriView()) {
                                            Text("Go to List Favoris")
                                        }
                                         NavigationLink(destination: InformationView()) {
                                           Text("Go to Information ")
                                       }
                                       .padding()

                                       NavigationLink(destination: ProfileView()) {
                                           Text("Go to Profile ")
                                       }
                                       .padding()
                                    }
                }

                Spacer(minLength: 200)

                Image("Image2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.trailing, 280)
            }
            .padding()
            .background(Color("BlueBackground"))
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
         
            
            
    
        }
        
    }
    
   
}
#Preview {
   SignInView()
}
