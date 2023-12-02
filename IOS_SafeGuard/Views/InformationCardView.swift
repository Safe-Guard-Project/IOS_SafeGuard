// InformationCardView.swift
import SwiftUI

struct InformationCardView: View {
    var information: Information
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Info image
            Image(information.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            
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


