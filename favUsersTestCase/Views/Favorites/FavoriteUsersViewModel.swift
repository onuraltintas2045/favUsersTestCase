//
//  FavoriteUsersViewModel.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 5.07.2025.
//

import Foundation

@MainActor
class FavoriteUsersViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedUserIDs: Set<String> = []
    @Published var selectionMode: Bool = false
    @Published var searchText: String = ""

    // MARK: - Dependencies
    private let mainViewModel: MainTabViewModel

    // MARK: Initialization
    init(mainViewModel: MainTabViewModel) {
        self.mainViewModel = mainViewModel
    }

    // MARK: Computed Properties
    var favoriteUsers: [User] {
        mainViewModel.filteredFavoriteUsers(searchText: searchText)
    }

    // MARK: - Selection Management
    func toggleSelectionMode() {
        selectionMode.toggle()
        if !selectionMode {
            selectedUserIDs.removeAll()
        }
    }

    func toggleSelection(for user: User) {
        if selectedUserIDs.contains(user.id) {
            selectedUserIDs.remove(user.id)
        } else {
            selectedUserIDs.insert(user.id)
        }
    }

    func toggleSelectAll() {
        let allUserIDs = Set(favoriteUsers.map(\.id))
        if selectedUserIDs == allUserIDs {
            selectedUserIDs.removeAll()
        } else {
            selectedUserIDs = allUserIDs
        }
    }

    func removeSelected() {
        for userID in selectedUserIDs {
            if let user = favoriteUsers.first(where: { $0.id == userID }) {
                mainViewModel.toggleFavorite(user)
            }
        }
        selectedUserIDs.removeAll()
        selectionMode = false
    }

    func resetSelectionMode() {
        selectionMode = false
        selectedUserIDs.removeAll()
    }
}
