import Combine
import UIKit
import SwiftUI

class Navigation2{

    func navigateToOtp(){
        NavigationLink(
            destination: OtpValidationView(),
            label: {
                Text("Sign In")
                    .padding()
            }
        )
    }
}
