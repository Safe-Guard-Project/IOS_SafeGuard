//
//  CommentAreaView.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import SwiftUI

struct CommentAreaView: View {
    @State private var comment: String = ""
    
    var body: some View {
        VStack {
              Text("Write your opinion:")
                  .font(.headline)

              TextEditor(text: $comment)
                  .border(Color.gray, width: 1)
                  .padding()

              Button("Submit Comment") {
                  // Implement comment submission logic here
              }
              .padding()
          }
    }
}

#Preview {
    CommentAreaView()
}
