//
//  RemoteImage.swift
//  IOS_SafeGuard
//
//  Created by abir on 12/12/2023.
//

// RemoteImage.swift
import SwiftUI

struct RemoteImage: View {
    private var url: URL

    init(url: URL) {
        self.url = url
    }

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            @unknown default:
                EmptyView()
            }
        }
    }
}
