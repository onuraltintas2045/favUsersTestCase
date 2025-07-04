//
//  FavoriteUserView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.favoriteUsers.map { fav in
                User(
                    id: fav.id,
                    fullName: fav.fullName,
                    email: fav.email,
                    age: 0, // Favorilerde yaş yoksa 0 yaz (veya SwiftData’ya ekle)
                    phone: fav.phone,
                    location: fav.location,
                    profileImageURL: fav.profileImageURL,
                    gender: fav.gender,
                    nationality: fav.nationality
                )
            }) { user in
                NavigationLink {
                    UserDetailView(user: user, viewModel: viewModel)
                } label: {
                    UserCardView(user: user, viewModel: viewModel)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
