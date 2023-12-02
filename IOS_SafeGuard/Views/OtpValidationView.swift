import SwiftUI

struct ContentView: View {
    @State private var block1: String = ""
    @State private var block2: String = ""
    @State private var block3: String = ""
    @State private var block4: String = ""
    @State private var isVerified: Bool? = nil

    var body: some View {
        VStack {
            Text("Enter OTP to Verify:")
                .font(.headline)
                .padding(.bottom, 10)

            HStack(spacing: 10) {
                PasswordBlockField("Block 1", text: $block1)
                PasswordBlockField("Block 2", text: $block2)
                PasswordBlockField("Block 3", text: $block3)
                PasswordBlockField("Block 4", text: $block4)
            }
            .padding()

            Button(action: {
                verifyOTP()
            }) {
                Text("Verify")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            if let isVerifiedValue = isVerified {
                Text(isVerifiedValue ? "OTP Verified!" : "Verification Failed!")
                    .font(.title)
                    .padding()
            }
        }
        .padding()
    }

    func verifyOTP() {
        let otp = block1 + block2 + block3 + block4
        // Add your OTP verification logic here
        // For example, check if the OTP meets your criteria

        // For testing purposes, let's assume any OTP with a specific value is valid
        self.isVerified = otp == "1234"
    }
}

struct PasswordBlockField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .frame(maxWidth: .infinity)
    }

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
