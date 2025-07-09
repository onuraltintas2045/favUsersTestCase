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

    func toggleSelectAll(users: [User]) {
        let allUserIDs = Set(users.map(\.id))
        if selectedUserIDs == allUserIDs {
            selectedUserIDs.removeAll()
        } else {
            selectedUserIDs = allUserIDs
        }
    }

    func resetSelectionMode() {
        selectionMode = false
        selectedUserIDs.removeAll()
    }
}
