//
//  UserCardView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct UserCardView: View {
    let user: User
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        HStack(spacing: 12) {
            // Profil fotoğrafı
            AsyncImage(url: URL(string: user.profileImageURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            // Ad ve e-posta
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Favori butonu
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
