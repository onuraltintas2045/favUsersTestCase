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
            Group {
                if mainTabViewModel.favoriteUsers.isEmpty {
                    ScrollView {
                        EmptyListView(
                            message: "No favorites yet.",
                            systemImage: "heart.slash"
                        )
                        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.6)
                    }
                } else {
                    List {
                        Section {
                            if viewModel.favoriteUsers.isEmpty {
                                VStack {
                                    EmptyListView(
                                        message: "No results found for your search.",
                                        systemImage: "magnifyingglass"
                                    )
                                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.5)
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                            } else {
                                ForEach(viewModel.favoriteUsers) { user in
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
                                .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 8))
                                .listRowSeparator(.hidden)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                }
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search by name or email"
            )
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.selectionMode {
                        Button("Select All") {
                            viewModel.toggleSelectAll()
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.selectionMode ? "Done" : "Select") {
                        viewModel.toggleSelectionMode()
                    }
                    .disabled(viewModel.favoriteUsers.isEmpty)
                }

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
