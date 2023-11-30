//
//  HomePageView.swift
//  IOS_SafeGuard
//
//  Created by Omar.Djebbi on 29/11/2023.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        TabView {
            Group {
                ForgetPasswordView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                            .foregroundColor(.black) // Set foreground color explicitly
                    }
                
                SignInView()
                    .tabItem {
                        Label("Blog", systemImage: "magnifyingglass")
                            .foregroundColor(.black) // Set foreground color explicitly
                    }
                
                ProgramView()
                    .tabItem {
                        Label("Learn", systemImage: "plus.circle.fill")
                            .foregroundColor(.black) // Set foreground color explicitly
                    }
                
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                            .foregroundColor(.black) // Set foreground color explicitly
                    }
                
                DisplayUserProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                            .foregroundColor(.black) // Set foreground color explicitly
                    }
            }
            .toolbarBackground(Color(red: 255, green: 255, blue: 255), for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    HomePageView()
}
