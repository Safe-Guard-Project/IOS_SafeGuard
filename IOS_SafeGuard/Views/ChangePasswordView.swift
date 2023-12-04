import SwiftUI

struct ChangePasswordView: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @ObservedObject private var changePasswordViewModel = ChangePasswordViewModel()

    var body: some View {
        VStack {
            Text("Change Password")
                .font(.largeTitle)
                .padding()

            SecureField("New Password", text: $newPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                changePasswordViewModel.changePassword(newPassword: newPassword, confirmPassword: confirmPassword) { result in
                    switch result {
                    case .success:
                        // Handle success if needed
                        break
                    case .failure(let error):
                        // Handle failure if needed
                        print(" \(error.localizedDescription)")
                    }
                }
            })
 {
                Text("Change Password")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .padding()
            }
            .disabled(changePasswordViewModel.changePasswordResult != nil)

            if let result = changePasswordViewModel.changePasswordResult {
                switch result {
                case .success:
                    Text("Password changed successfully!")
                        .foregroundColor(.green)
                        .padding()
                case .failure(let error):
                    Text("\(error.localizedDescription)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
