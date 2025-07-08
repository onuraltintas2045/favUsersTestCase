//
//  UserRepository.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation
import SwiftData

enum UserRepositoryError: Error, LocalizedError {
    case saveFailed
    case fetchFailed
    case deleteFailed

    var errorDescription: String? {
        switch self {
        case .saveFailed: return "Failed to save favorite user."
        case .fetchFailed: return "Failed to fetch favorite users."
        case .deleteFailed: return "Failed to remove favorite user."
        }
    }
}

class UserRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func addFavorite(_ user: User) throws {
        let fav = FavoriteUser(from: user)
        context.insert(fav)
        do {
            try context.save()
        } catch {
            print("❌ Error saving favorite user: \(error)")
            throw UserRepositoryError.saveFailed
        }
    }

    func removeFavorite(_ user: User) throws {
        let descriptor = FetchDescriptor<FavoriteUser>(
            predicate: #Predicate { $0.id == user.id }
        )
        do {
            if let fav = try context.fetch(descriptor).first {
                context.delete(fav)
                try context.save()
            }
        } catch {
            print("❌ Error removing favorite user: \(error)")
            throw UserRepositoryError.deleteFailed
        }
    }

    func isFavorite(_ user: User) throws -> Bool {
        let descriptor = FetchDescriptor<FavoriteUser>(
            predicate: #Predicate { $0.id == user.id }
        )
        do {
            let results = try context.fetch(descriptor)
            return !results.isEmpty
        } catch {
            print("❌ Error checking favorite status: \(error)")
            throw UserRepositoryError.fetchFailed
        }
    }

    func fetchFavorites() throws -> [FavoriteUser] {
        let descriptor = FetchDescriptor<FavoriteUser>()
        do {
            return try context.fetch(descriptor)
        } catch {
            print("❌ Error fetching favorite users: \(error)")
            throw UserRepositoryError.fetchFailed
        }
    }
}
