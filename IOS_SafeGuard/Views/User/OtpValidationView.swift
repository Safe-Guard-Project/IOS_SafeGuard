import SwiftUI

struct OtpValidationView: View {
    @State private var block1: String = ""
    @State private var block2: String = ""
    @State private var block3: String = ""
    @State private var block4: String = ""
    @State private var isVerified: Bool? = nil

    // Use @AppStorage to retrieve values stored in AppStorage
    @AppStorage("OtpCodeKey") private var storedOtpCode: String = ""
    @AppStorage("OtpResponseKey") private var storedOtpResponse: String = ""

    @State private var navigateToChangePass: Bool = false

    var body: some View {
        VStack {
            Text("Enter OTP to Verify:")
                .font(.headline)
                .padding(.bottom, 10)

            HStack(spacing: 10) {
                SecureField("Block 1", text: $block1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)

                SecureField("Block 2", text: $block2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)

                SecureField("Block 3", text: $block3)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)

                SecureField("Block 4", text: $block4)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .padding()

            Button(action: {
                self.isVerified = self.verifyOTP(enteredOTP: self.block1 + self.block2 + self.block3 + self.block4)

                // Set navigateToChangePass based on OTP verification
                self.navigateToChangePass = self.isVerified ?? false
            }) {
                Text("Verify")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            if let isVerifiedValue = isVerified {
                if isVerifiedValue {
                    Text("OTP Verified!")
                        .font(.title)
                        .padding()

                    // Use NavigationLink here based on the condition
                    NavigationLink(
                        destination: ChangePasswordView(),
                        isActive: $navigateToChangePass,
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()  // Hide the navigation link, but it will still trigger the navigation
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                }
            }
        }
    }

    func verifyOTP(enteredOTP: String) -> Bool {
        // Use the @AppStorage values directly
        let storedOtpCode = self.storedOtpCode
        let storedOtpResponse = self.storedOtpResponse

        // Add your OTP verification logic here
        return enteredOTP == storedOtpCode || enteredOTP == storedOtpResponse
    }
}

#Preview {
    OtpValidationView()
}
