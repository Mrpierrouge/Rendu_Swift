//
//  LeaderboardView.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//
import SwiftUI

struct LeaderboardView: View {
    var currentUser: UserProfileModel
    @State var allUsers: [UserProfileModel]
    
    var sortedUsers: [UserProfileModel] {
        allUsers.sorted { $0.score > $1.score }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(sortedUsers) { user in
                        HStack(spacing: 16) {
                            avatarView(for: user)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.username)
                                    .font(.headline)
                                Text("Score : \(user.score)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                HStack {
                                    Text("🏆 \(user.wins) victoires")
                                    Text("🌞 \(user.dailyWins) daily")
                                }
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
                                        .stroke(user.id == currentUser.id ? .blue : .clear, lineWidth: 2)
                                )
                        )
                        .padding(.horizontal)
                    }
                    Spacer(minLength: 80)
                }
                .padding(.vertical)
            }
            
            // --- Profil du joueur courant en bas ---
            VStack {
                Divider()
                HStack(spacing: 16) {
                    avatarView(for: currentUser)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Vous : \(currentUser.username)")
                            .font(.headline)
                        Text("Score : \(currentUser.score)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        HStack {
                            Text("🏆 \(currentUser.wins)")
                            Text("🌞 \(currentUser.dailyWins)")
                            Text("❌ \(currentUser.losses)")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                .padding()
            }
            .background(.ultraThinMaterial)
        }
        .navigationTitle("🏅 Leaderboard")
    }
    
    @ViewBuilder
    func avatarView(for user: UserProfileModel) -> some View {
        if let image = user.avatarImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        } else {
            Circle()
                .fill(.gray.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(Image(systemName: "person.fill").foregroundStyle(.gray))
        }
    }
}
