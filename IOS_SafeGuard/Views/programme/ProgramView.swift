//
//  ProgramView.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//

import SwiftUI

struct ProgramView: View {
    
    var body: some View {
        
       
        NavigationView {
            List {
             
                ForEach(0..<2) { index in
               
                    ProgramCardView()
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                }
            }
            .navigationTitle("Programmes").navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProgramView()
}
