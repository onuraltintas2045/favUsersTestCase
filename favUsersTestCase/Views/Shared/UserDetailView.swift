//
//  UserDetailView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 4.07.2025.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    @EnvironmentObject var viewModel: MainTabViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                
                UserProfileImageView(imageUrl: user.profileImageURL, imageSize: 200)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(
                        Circle()
                            .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                    )
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity)

                Text(user.fullName)
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.center)

                VStack(spacing: 8) {
                    infoRow(systemImage: "envelope.fill", text: user.email, color: .blue)
                    infoRow(systemImage: "calendar", text: "Age: \(user.age)", color: .purple)
                    infoRow(systemImage: "phone.fill", text: user.phone, color: .green)
                    infoRow(systemImage: "map.fill", text: user.location, color: .orange)
                    infoRow(systemImage: "figure.dress.line.vertical.figure", text: user.gender.capitalized, color: .pink)
                    infoRow(systemImage: "globe.europe.africa", text: user.nationality, color: .teal)
                }
                .padding(.horizontal)

                Button(action: {
                    viewModel.toggleFavorite(user)
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: viewModel.isFavorite(user) ? "heart.fill" : "heart")
                            .font(.system(size: 24))
                            .foregroundStyle(viewModel.isFavorite(user) ? .red : .gray)
                        
                        Text(viewModel.isFavorite(user) ? "Remove Favorite" : "Add Favorite")
                            .foregroundColor(.primary)
                            .bold()
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                }
                .padding(.top, 10)
            }
            .padding(.bottom, 40)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle(user.fullName)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func infoRow(systemImage: String, text: String, color: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(8)
                .background(color.gradient)
                .clipShape(Circle())
            Text(text)
                .foregroundColor(.primary)
                .font(.body)
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
