//
//  FavoriteUserView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List(viewModel.filteredFavoriteUsers(searchText: searchText)) { user in
                NavigationLink {
                    UserDetailView(user: user, viewModel: viewModel)
                } label: {
                    UserCardView(user: user, viewModel: viewModel)
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large) // Büyük başlık
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search by name or email")
        }
    }
}
