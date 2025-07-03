//
//  FavoriteUser.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation
import SwiftData

@Model
final class FavoriteUser: Identifiable {
    @Attribute(.unique) var id: String
    var fullName: String
    var email: String
    var age: Int
    var phone: String
    var location: String
    var profileImageURL: String
    var gender: String
    var nationality: String

    init(
        id: String,
        fullName: String,
        email: String,
        age: Int,
        phone: String,
        location: String,
        profileImageURL: String,
        gender: String,
        nationality: String
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.age = age
        self.phone = phone
        self.location = location
        self.profileImageURL = profileImageURL
        self.gender = gender
        self.nationality = nationality
    }
}

extension FavoriteUser {
    convenience init(from user: User) {
        self.init(
            id: user.id,
            fullName: user.fullName,
            email: user.email,
            age: user.age,
            phone: user.phone,
            location: user.location,
            profileImageURL: user.profileImageURL,
            gender: user.gender,
            nationality: user.nationality
        )
    }
}
