//
//  UserProfileImageView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 5.07.2025.
//

import Kingfisher
import SwiftUI

struct UserProfileImageView: View {
    let imageUrl: String
    let imageSize: CGFloat

    var body: some View {
        KFImage(URL(string: imageUrl))
            .placeholder {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray.opacity(0.6))
                    .background(Color.gray.opacity(0.2))
            }
            .resizable()
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
    }
}
