//
//  FavoriCardView.swift
//  IOS_SafeGuard
//
//  Created by abir on 29/11/2023.
//

import SwiftUI

struct FavoriCardView: View {
    var favorie: Favorie
    @State private var isFavorite: Bool = false
    @StateObject private var favorieViewModel = FavorieViewModel()
    @State private var isDeleted: Bool = false


    var body: some View {
        if !isDeleted {
            VStack(alignment: .leading, spacing: 8) {
              
                
              /*  GeometryReader { geometry in
                    Image(favorie.idCoursProgramme.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width - 80, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .offset(x: 40, y: 10)
                }
                .frame(height: 200)
                */
                AsyncImage(url: URL(string: favorie.idCoursProgramme.image)) { phase in
                                     switch phase {
                                     case .empty:
                                         ProgressView()
                                     case .success(let image):
                                         image
                                             .resizable()
                                             .aspectRatio(contentMode: .fill)
                                             .frame(height: 160)
                                             .clipped()
                                     case .failure:
                                         Image(systemName: "Intro") 
                                             .resizable()
                                             .aspectRatio(contentMode: .fill)
                                             .frame(height: 200)
                                             .clipped()
                                     @unknown default:
                                         EmptyView()
                                     }
                                 }

                Text(favorie.idCoursProgramme.description)
                    .font(.body)
                    .padding(16)
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(10)
            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
            .swipeActions(edge: .trailing) {
                Button("Delete", systemImage: "trash") {
                    favorieViewModel.deletefav(favorie: favorie)
                    isDeleted = true
                }
                .tint(.red)
                
                
                
            }
        }
    }

}
