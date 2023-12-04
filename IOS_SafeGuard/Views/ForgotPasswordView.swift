import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var phone: String = ""
    @StateObject private var recEmailViewModel = RecEmailViewModel()
    @StateObject private var recNumTelViewModel = RecNumTelViewModel()
    @State private var isForgetPasswordOn: Bool = false // Track login state

    @AppStorage("OtpResponseKey") private var storedOtpResponse: String = ""
    @AppStorage("OtpCodeKey") private var storedOtpCode: String = ""
    @State private var navigateToOtpValidation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Forgot Password")
                    .font(.largeTitle)
                    .padding()
                
                Text("Please enter your registered email or phone number to reset your password")
                    .font(.headline)
                    .padding()
                
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    recEmailViewModel.ForgetPasswordByEmail(email: email) { result in
                        switch result {
                        case .success(let otpResponse):
                            // Handle success
                            print("Received OTP Response (Email): \(otpResponse)")
                            storedOtpResponse = otpResponse.resetCode


                                               
                            self.isForgetPasswordOn = true

                        case .failure(let error):
                            // Handle failure
                            print("Failed to receive OTP Response (Email): \(error.localizedDescription)")
                        }
                    }
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding()
                }
                
                Text("OR")
                    .font(.headline)
                    .padding()
                
                TextField("Phone", text: $phone)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    recNumTelViewModel.ForgetPasswordByPhoneNumber(numeroTel: phone) { result in
                        switch result {
                        case .success(let otpCode):
                            // Handle success
                            print("Received OTP Code (Phone): \(otpCode)")
                            storedOtpCode = otpCode.otpCode
                            self.isForgetPasswordOn = true

                        case .failure(let error):
                            // Handle failure
                            print("Failed to receive OTP Code (Phone): \(error.localizedDescription)")
                        }
                    }
                }) {
                    Text("Send SMS")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding()
                }
                
                // Display the response message for phone number
                
                .padding()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .background(
                    NavigationLink(
                        destination: OtpValidationView(),
                        isActive: $isForgetPasswordOn,
                        label: {
                            Text("Forgot Password")
                                .padding()
                        }
                    )
                    )
            }
        }
    }
}


