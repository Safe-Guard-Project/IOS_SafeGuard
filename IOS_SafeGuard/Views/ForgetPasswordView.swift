import SwiftUI

struct ForgetPasswordView: View {
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var otpcode: String = ""

    @State private var isSendSMSEnabled: Bool = false

    var body: some View {
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
                // Handle Submit
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
                isSendSMSEnabled.toggle()
            }) {
                Text("Send SMS 个 ")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .padding()
            }
            
            if isSendSMSEnabled {
                TextField("Enter Code", text: $otpcode)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    // Handle Verify SMS Code
                }) {
                    Text("Verify SMS Code")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding()
                }
            }
        }
        .padding()
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
#Preview {
    ForgetPasswordView()
}
