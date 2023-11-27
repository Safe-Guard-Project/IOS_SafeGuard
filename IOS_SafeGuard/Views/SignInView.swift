import Foundation
import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginFailed = false
    @State private var agreeTerms: Bool = false
    
    var body: some View {
  
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                            Image("Image1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding(.leading, 280)
                            
                        }
            Text("Sign In")
                .font(.largeTitle)
                .padding(.leading, 40)
            
            VStack(alignment: .leading, spacing: 10) {

                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 353, height: 51)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 1)
                            .stroke(.black, lineWidth: 2)
                    )
                    .overlay(
                        TextField("Email", text: $email)
                            .padding()
                    )
            }
            
            
            VStack(alignment: .leading, spacing: 10) {
   
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 353, height: 51)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 1)
                            .stroke(.black, lineWidth: 2)
                    )
                    .overlay(
                        TextField("Password", text: $password)
                            .padding()
                    )
                VStack {
                        Spacer()
                          .frame(height: 2)
                           .background(Color.red)
                   }
                .frame(height: 10)
            }
            
     
            
            HStack {
                Spacer()

                

                Button(action: {
                    // Perform your action for signing in
                }) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 243, height: 51)
                        .background(Color(red: 0, green: 0.28, blue: 1))
                        .cornerRadius(50)
                        .overlay(
                            Text("Sign in")
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                }
                .onTapGesture {
                    print("Sign In button tapped.")
                }

                    .disabled(!agreeTerms)

                Spacer()
            }
            
            if isLoginFailed {
                Text("Incorrect email or password. Please try again.")
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                // Perform your action for redirecting to sign up screen
            }) {
                Text("Don't have an account?")
                    .foregroundColor(.black)
                    .padding()
                Button(action: {
                    // Perform your action for redirecting to sign up screen
                }) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            
            Spacer(minLength: 200)
         
            Image("Image2")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .padding(.trailing, 280) // Adjust the leading padding
           
        }
        
        .padding()
        .background(Color("BlueBackground"))
    }
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView()
        }
    }
}


#Preview {
  SignInView()
}
