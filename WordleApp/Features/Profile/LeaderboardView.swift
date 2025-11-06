//
//  LeaderboardView.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//
import SwiftUI

struct LeaderboardView: View {
    init(currentUser: UserProfileModel) {
        _leaderboard = StateObject(wrappedValue: LeaderboardViewModel(currentUser: currentUser))
    }
    @StateObject var leaderboard: LeaderboardViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(leaderboard.sortedUsers) { user in
                        let info = leaderboard.userDisplayInfo(for: user)
                        LeaderboardRowView(
                            user: user,
                            isCurrentUser: leaderboard.isCurrentUser(user),
                            username: info.username,
                            score: info.score,
                            stats: info.stats
                        )
                    }
                    Spacer(minLength: 80)
                }
                .padding(.vertical)
            }
            
            VStack {
                Divider()
                HStack(spacing: 16) {
                    AvatarView(image: leaderboard.currentUser.avatarImage)
                    VStack(alignment: .leading, spacing: 4) {
                        let user = leaderboard.currentUser
                        Text("Vous : \(user.username)").font(.headline)
                        Text("Score : \(user.score)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text("Wins : \(user.wins)  Dailys : \(user.dailyWins)  Loses : \(user.losses)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                .padding()
            }
            .background(.ultraThinMaterial)
        }
        .navigationTitle("Leaderboard")
        .onAppear { leaderboard.refresh() }
    }
}

