import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLogin: Bool = false // Track login state
    
    @StateObject private var signInViewModel = SignInViewModel()
    @State private var user: User? = nil


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

                HStack {
                        SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                       .padding()

                        NavigationLink(
                                       destination: ForgotPasswordView(), // Replace with your Forgot Password view
                                       label: {
                                           Text("Forgot Password")
                                               .foregroundColor(.blue)
                                       })
                               }


                HStack {
                    Spacer()
                    Button(action: {
                        signInViewModel.email = email
                        signInViewModel.password = password
                        signInViewModel.signIn(email: email, password: password) { result in
                            switch result {
                            case .success(let user):
                                self.user = user
                                // Save user data to UserDefaults
                                UserDefaults.standard.set(user._id, forKey: "UserID")
                                UserDefaults.standard.set(user.UserName, forKey: "UserName")
                                UserDefaults.standard.set(user.email, forKey: "email")
                                UserDefaults.standard.set(user.numeroTel, forKey: "numeroTel")
                                // Navigate to DisplayUserProfileView
                                self.isLogin = true

                                //Navigation().navigateToProfile()
                            case .failure(let error):
                                print("Sign-in failed: \(error)")
                                self.isLogin = false
                            }
                        }
                    }) {
                        Text("Sign in")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 243, height: 51)
                            .background(Color(red: 0, green: 0.28, blue: 1))
                            .cornerRadius(50)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled($signInViewModel.isSigningIn.wrappedValue)
                    Spacer()
                }

                if isLogin {
                    Text("you've entered correct email and password ")
                        .foregroundColor(.green)
                        .padding()
                }
                else {
                    Text("Enter your email and/or password or check the validaty of them ")
                        .foregroundColor(.red)
                        .padding()
                }
            

                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                        .padding()

                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Sign Up")
                                .padding()
                        }
                    )
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
            .background(
            NavigationLink(
                destination: DisplayUserProfileView(),
                isActive: $isLogin,
                label: EmptyView.init
            )
            )
        }
    }
}
