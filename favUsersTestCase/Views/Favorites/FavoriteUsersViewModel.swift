//
//  FavoriteUsersViewModel.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 5.07.2025.
//

import Foundation

@MainActor
class FavoriteUsersViewModel: ObservableObject {
    @Published var selectedUserIDs: Set<String> = []
    @Published var selectionMode: Bool = false
    @Published var searchText: String = ""

    private let mainViewModel: MainTabViewModel

    init(mainViewModel: MainTabViewModel) {
        self.mainViewModel = mainViewModel
    }

    var favoriteUsers: [User] {
        mainViewModel.filteredFavoriteUsers(searchText: searchText)
    }


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

    func removeSelectedFavorites() {
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
