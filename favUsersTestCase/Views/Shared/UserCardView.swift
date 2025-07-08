//
//  UserCardView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct UserCardView: View {
    let user: User
    @EnvironmentObject var viewModel: MainTabViewModel

    var body: some View {
        HStack(spacing: 12) {
            
            UserProfileImageView(imageUrl: user.profileImageURL, imageSize: 60)
                .clipShape(Circle())
                .shadow(radius: 3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Button(action: {
                viewModel.toggleFavorite(user)
            }) {
                Image(systemName: viewModel.isFavorite(user) ? "heart.fill" : "heart")
                    .foregroundStyle(viewModel.isFavorite(user) ? .red : .gray)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}
