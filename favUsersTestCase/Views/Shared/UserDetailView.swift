//
//  UserDetailView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 4.07.2025.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    @EnvironmentObject var viewModel: MainTabViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                UserProfileImageView(imageUrl: user.profileImageURL, imageSize: 200)

                Text(user.fullName).font(.largeTitle).bold()
                Text(user.email).foregroundColor(.secondary)
                Text("Age: \(user.age)")
                Text("Phone: \(user.phone)")
                Text("Location: \(user.location)")
                Text("Gender: \(user.gender.capitalized)")
                Text("Nationality: \(user.nationality)")

                Button(action: {
                    viewModel.toggleFavorite(user)
                }) {
                    HStack {
                        Image(systemName: viewModel.isFavorite(user) ? "heart.fill" : "heart")
                            .foregroundStyle(viewModel.isFavorite(user) ? .red : .primary)
                        Text(viewModel.isFavorite(user) ? "Remove Favorite" : "Add to Favorites")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(user.fullName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
