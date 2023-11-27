import SwiftUI

struct ContentView: View {
    let users: [User]

    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    VStack(alignment: .leading) {
                        Text(user.UserName)  // Use the updated property name
                            .font(.headline)
                        HStack {
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(user.numeroTel)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationBarTitle("Users")
        }
    }
}

struct DiplayView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(users: [
            User(_id: "1", UserName: "omardjo", email: "mr.djebbi@gmail.com", password: "password", Role: .client, latitudeUser: 0, longitudeUser: 0, numeroTel: "53115231"),
        ])
    }
}
