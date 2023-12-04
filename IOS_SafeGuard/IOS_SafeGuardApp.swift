//
//  IOS_SafeGuardApp.swift
//  IOS_SafeGuard
//
//  Created by Omar.Djebbi on 9/11/2023.
//

import SwiftUI

@main
struct IOS_SafeGuardApp: App {
    var body: some Scene {
        WindowGroup {
            // SplashScreenView()
            //ProgramView()
            //CommentsView()
            //  FavoriView()
            NavigationView {
                VStack(spacing: 20) {
                    NavigationLink(destination: ProgramView()) {
                        Text("Go to Program")
                    }
                    
                    NavigationLink(destination: CommentsView()) {
                        Text("Go to Comment")
                    }
                    
                    
                    NavigationLink(destination:FavoriView()) {
                        Text("Go to List Favoris")
                        
                        
                        
                        
                    }}
            }
        }}
}
