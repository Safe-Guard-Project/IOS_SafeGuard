/*// InformationCardView.swift
import SwiftUI

struct InformationCardView: View {
    var information: Information
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Info image
            if let imageUrl = information.image, let url = URL(string: imageUrl) {
                // Use AsyncImage or other image loading techniques as needed
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()

                    case .failure:
                        // Handle failure or show a placeholder
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    case .empty:
                        // Show a placeholder or loading indicator
                        ProgressView()
                    @unknown default:
                        // Handle unknown state
                        EmptyView()
                    }
                }
            } else {
                // If image is nil, show a placeholder or handle as needed
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            }
            
            // Info details
            VStack(alignment: .leading, spacing: 8) {
                // Event title
                Text(information.titre)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center) // Center the title

                // Event description
                Text(information.descriptionInformation)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(16)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(10)
    }
}
*/
