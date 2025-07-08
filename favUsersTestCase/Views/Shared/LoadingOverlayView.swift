//
//  LoadingOverlayView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 8.07.2025.
//

import SwiftUI

struct LoadingOverlayView: View {
    private let isVisible: Bool

    init(isVisible: Bool = true) {
        self.isVisible = isVisible
    }

    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: isVisible)
        }
    }
}

extension View {
    func loadingOverlay(_ isVisible: Bool) -> some View {
        self.overlay(
            LoadingOverlayView(isVisible: isVisible)
        )
    }
}
