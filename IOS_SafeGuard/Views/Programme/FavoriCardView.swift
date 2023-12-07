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
                let image = extractImage(from: favorie.idCoursProgramme)
                let description = extractDescription(from: favorie.idCoursProgramme)
                
                GeometryReader { geometry in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width - 80, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .offset(x: 40, y: 10)
                }
                .frame(height: 200)
                
                Text(description)
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
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                
                
                
            }
        }
    }


    func extractImage(from idCoursProgramme: String) -> String {
    
        return "image"
    }

    
    func extractDescription(from idCoursProgramme: String) -> String {
        
        return "Description avec id \(idCoursProgramme)"
    }
}
