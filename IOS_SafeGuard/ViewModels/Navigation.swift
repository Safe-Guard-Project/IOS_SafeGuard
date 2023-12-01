import Combine
import UIKit
import SwiftUI

class Navigation{

    func navigateToProfile(){
        NavigationLink(
            destination: DisplayUserProfileView(),
            label: {
                Text("Sign In")
                    .padding()
            }
        )
    }
}
