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
        HStack(spacing: 10) {
            
            UserProfileImageView(imageUrl: user.profileImageURL, imageSize: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: {
                viewModel.toggleFavorite(user)
            }) {
                Image(systemName: viewModel.isFavorite(user) ? "heart.fill" : "heart")
                    .foregroundStyle(viewModel.isFavorite(user) ? .red : .primary)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }
}
