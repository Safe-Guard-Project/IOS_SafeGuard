//
//  ContentView.swift
//  IOS_SafeGuard
//
//  Created by dhiasaibi on 28/11/2023.
//

import SwiftUI

struct ContentViewCatastrophe: View {
    @StateObject private var viewModel = CatastropheViewModel(repository: <#T##CatastropheRepository#>)

    var body: some View {
        NavigationView {
            CatastropheListView(catastrophes: $viewModel.catastrophes)
                .navigationBarTitle("Catastrophes", displayMode: .inline)
        }
        .onAppear {
            viewModel.getCatastrophes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCatastrophe()
    }
}
