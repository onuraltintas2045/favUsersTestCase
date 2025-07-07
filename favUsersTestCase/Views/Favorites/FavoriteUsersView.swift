//
//  FavoriteUserView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoriteUsersViewModel
    @EnvironmentObject var mainTabViewModel: MainTabViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.favoriteUsers) { user in
                HStack {
                    if viewModel.selectionMode {
                        Image(systemName: viewModel.selectedUserIDs.contains(user.id) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(viewModel.selectedUserIDs.contains(user.id) ? .blue : .gray)
                            .onTapGesture {
                                viewModel.toggleSelection(for: user)
                            }
                    }

                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        UserCardView(user: user)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search by name or email"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.selectionMode {
                        Button(viewModel.selectedUserIDs.count == viewModel.favoriteUsers.count ? "Deselect All" : "Select All") {
                            viewModel.toggleSelectAll()
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.selectionMode ? "Done" : "Select") {
                        viewModel.toggleSelectionMode()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if viewModel.selectionMode {
                        Button(role: .destructive) {
                            viewModel.removeSelectedFavorites()
                        } label: {
                            HStack {
                                Image(systemName: "heart.slash")
                                Text("Unlike (\(viewModel.selectedUserIDs.count))")
                            }
                        }
                        .disabled(viewModel.selectedUserIDs.isEmpty)
                    }
                }
            }
            .onDisappear {
                viewModel.resetSelectionMode()
            }
        }
    }
}
