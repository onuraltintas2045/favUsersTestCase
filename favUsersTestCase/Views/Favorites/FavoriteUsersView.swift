//
//  FavoriteUserView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct FavoritesView: View {

    // MARK: - Properties
    @ObservedObject var viewModel: FavoriteUsersViewModel
    @EnvironmentObject var mainTabViewModel: MainTabViewModel
    @State private var searchText: String = ""

    // MARK: - Body
    var body: some View {
        let filteredFavorites = mainTabViewModel.filteredFavoriteUsers(searchText: searchText)
        NavigationStack {
            Group {
                if mainTabViewModel.favoriteUsers.isEmpty {
                    // MARK: - Empty State
                    ScrollView {
                        EmptyListView(
                            message: "No favorites yet.",
                            systemImage: "heart.slash"
                        )
                        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.6)
                    }
                } else {
                    // MARK: - Favorites List
                    List {
                        Section {
                            if filteredFavorites.isEmpty {
                                // MARK: - Empty Search Result
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
                                // MARK: - Favorite User Rows
                                ForEach(filteredFavorites) { user in
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
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search by name or email"
            )
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                // MARK: - Selection Management
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.selectionMode {
                        Button("Select All") {
                            viewModel.toggleSelectAll(users: filteredFavorites)
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.selectionMode ? "Done" : "Select") {
                        viewModel.toggleSelectionMode()
                    }
                    .disabled(mainTabViewModel.favoriteUsers.isEmpty)
                }

                ToolbarItem(placement: .bottomBar) {
                    if viewModel.selectionMode {
                        Button(role: .destructive) {
                            mainTabViewModel.removeUsersFromFavorites(userIDs: viewModel.selectedUserIDs)
                            viewModel.resetSelectionMode()
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
