//
//  UserRepository.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation
import SwiftData

class UserRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func addFavorite(_ user: User) {
        let fav = FavoriteUser(from: user)
        context.insert(fav)
        try? context.save()
    }

    func removeFavorite(_ user: User) {
        let descriptor = FetchDescriptor<FavoriteUser>(
            predicate: #Predicate { $0.id == user.id }
        )
        if let fav = try? context.fetch(descriptor).first {
            context.delete(fav)
            try? context.save()
        }
    }

    func isFavorite(_ user: User) -> Bool {
        let descriptor = FetchDescriptor<FavoriteUser>(
            predicate: #Predicate { $0.id == user.id }
        )
        let results = (try? context.fetch(descriptor)) ?? []
        return !results.isEmpty
    }

    func fetchFavorites() -> [FavoriteUser] {
        let descriptor = FetchDescriptor<FavoriteUser>()
        return (try? context.fetch(descriptor)) ?? []
    }
}
