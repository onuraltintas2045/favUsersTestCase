//
//  User.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation

// MARK: - UI Model
struct User: Identifiable, Equatable, Codable {
    let id: String
    let fullName: String
    let email: String
    let age: Int
    let phone: String
    let location: String
    let profileImageURL: String
    let gender: String
    let nationality: String
}

// MARK: - API Mapping
extension User {
    // MARK: - User Api Response Model
    struct UserResponse: Codable {
        let gender: String
        let name: Name
        let location: Location
        let email: String
        let dob: DOB
        let phone: String
        let picture: Picture
        let nat: String
        let login: Login

        // MARK: - Nested Models
        struct Name: Codable {
            let first: String
            let last: String
        }

        struct Location: Codable {
            let city: String
            let state: String
            let country: String
        }

        struct DOB: Codable {
            let age: Int
        }

        struct Picture: Codable {
            let large: String
        }

        struct Login: Codable {
            let uuid: String
        }
    }

    // MARK: - API Root Response
    struct UserRootResponse: Codable {
        let results: [UserResponse]
    }
}

