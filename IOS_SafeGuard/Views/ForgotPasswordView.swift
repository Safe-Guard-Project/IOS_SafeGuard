import SwiftUI
import Combine

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var phone: String = ""
    @ObservedObject private var recoverPasswordModel: RecoverPasswordModel
    
    // Add a State variable to store the response
    @State private var responseMessage: String?
    
    // Declare cancellables set
    @State private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.recoverPasswordModel = RecoverPasswordModel(userRepository: UserRepositoryImpl(apiService: ApiManager.shared, webServiceProvider: WebServiceProvider.shared))
    }
    
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
                recoverPasswordModel.recoverPasswordByEmail(email: email)
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
                recoverPasswordModel.recoverPasswordByPhone(numeroTel: phone)
            }) {
                Text("Send SMS")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .padding()
            }
            
            // Display the response message
            if let resetCode = recoverPasswordModel.resetCode {
                Text("Received Reset Code: \(resetCode)")
                    .foregroundColor(.green)
                    .padding()
            } else if let error = recoverPasswordModel.error {
                Text("Failed to receive Reset Code: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            // Add sink to handle the response from the model
            recoverPasswordModel.$response
                .sink { result in
                    switch result {
                    case .success(let resetCode?):
                        handleResponse(resetCode)
                    case .success(nil):
                        responseMessage = "Failed to receive Reset Code"
                        print("Failed to receive Reset Code")
                    case .failure(let error):
                        handleResponseError(error)
                    case .none:
                        responseMessage = "Failed to receive Reset Code"
                        print("Failed to receive Reset Code")
                    }
                }
                .store(in: &cancellables)
            }

    }
    
    // Function to handle the response from the API
    
    private func handleResponse(_ resetCode: String?) {
        DispatchQueue.main.async {
            switch resetCode {
            case let resetCode?:
                // Save the reset code to UserDefaults or handle it as needed
                UserDefaults.standard.set(resetCode, forKey: "otpCode")
                responseMessage = "Received Reset Code: \(resetCode)"
                print("Received Reset Code: \(resetCode)")
            case nil:
                responseMessage = "Failed to receive Reset Code"
                print("Failed to receive Reset Code")
            }
        }
    }

    
    // Function to handle errors
    private func handleResponseError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                responseMessage = "Error: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            } else {
                responseMessage = "Unknown error occurred"
                print("Unknown error occurred")
            }
        }
    }
    
    
    struct ForgotPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            ForgotPasswordView()
        }
    }
}
