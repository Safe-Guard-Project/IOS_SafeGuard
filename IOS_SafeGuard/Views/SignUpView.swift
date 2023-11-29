//
//  SignUp.swift
//  IOS_SafeGuard
//
//  Created by Omar.Djebbi on 26/11/2023.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var numeroTel: String = ""
    @State private var temporaryIsActive: Bool? = nil
    @State private var agreeTerms: Bool = false
    @StateObject private var signUpViewModel = SignUpViewModel()

        
        @State private var isSendSMSEnabled = false


    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
           
            HStack {
                            Image("Image1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding(.leading, 280)
                                Spacer()
                            
                        }
            
            Text("Sign Up")
                .font(.largeTitle)
                .padding(.leading, 40)
            
            
            VStack(alignment: .leading, spacing: 10) {
          
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 353, height: 51)
                    .overlay(
                        TextField("Full Name", text: $fullName)
                            .padding()
                    )
                Spacer() // Add Spacer to center the RoundedRectangle vertically

            }
            
            VStack(alignment: .leading, spacing: 10) {
                
       
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 353, height: 51)
                    .overlay(
                        TextField("Email", text: $email)
                            .padding()
                    )
                Spacer() // Add Spacer to center the RoundedRectangle vertically

            }
            VStack(alignment: .leading, spacing: 10) {
                
       
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 353, height: 51)
                    .overlay(
                        TextField("NumeroTel", text: $numeroTel)
                            .padding()
                    )
                Spacer() // Add Spacer to center the RoundedRectangle vertically

            }
            
            VStack(alignment: .leading, spacing: 10) {
  
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 353, height: 51)
                    .overlay(
                        SecureField("Password", text: $password)
                            .padding()
                    )
            }
            HStack {
                Image(systemName: agreeTerms ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(agreeTerms ? .green : .gray)
                    .onTapGesture {
                        agreeTerms.toggle()


                    
                    }
                
                Text("Agree to the companies terms and services.")
                    .font(.headline)
            }
            .padding()
            
            HStack {
                Spacer() // Center the text horizontally

                Spacer()
                Button(action: {
                    print("FullName: \(fullName), Email: \(email), Password: \(password), PhoneNumber: \(numeroTel)")

                    signUpViewModel.UserName = fullName
                        signUpViewModel.email = email
                        signUpViewModel.password = password
                        signUpViewModel.phoneNumber = numeroTel
                        signUpViewModel.signUp()            }) {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(Color(red: 0, green: 0.28, blue: 1))
                        .frame(width: 243, height: 51)
                        .overlay(
                            Text("Sign up")
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                }

                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer() // Center the text horizontally
                
                Text("Already got an account then")
                    .font(.headline)
                    .padding(.leading, 30)
                
                NavigationLink(
                    destination: SignInView(),
                    label: {
                        Text("Sign In")
                            .foregroundColor(.blue)
                            .padding()
                    }
                )
                
                
            }
            Image("Image2")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .padding(.trailing, 40) // Adjust the leading padding
           
        }
        NavigationLink(
            destination: SignInView(),
            tag: true,
            selection: $temporaryIsActive,
            label: {
                EmptyView()
            }
        )
        .background(Color("BlueBackground"))

   
    }
    
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
    
}
#Preview {
    SignUpView()
}
