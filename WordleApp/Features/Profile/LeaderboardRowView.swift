//
//  LeaderboardRowView.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//


import SwiftUI

struct LeaderboardRowView: View {
    let user: UserProfileModel
    let isCurrentUser: Bool
    let username: String
    let score: String
    let stats: String
    
    var body: some View {
        HStack(spacing: 16) {
            AvatarView(image: user.avatarImage)
            VStack(alignment: .leading, spacing: 4) {
                Text(username).font(.headline)
                Text(score)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(stats)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isCurrentUser ? .blue : .clear, lineWidth: 2)
                )
        )
        .padding(.horizontal)
    }
}
