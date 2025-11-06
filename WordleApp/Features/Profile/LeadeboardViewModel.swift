//
//  LeadeboardViewModel.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//

import SwiftUI

@Observable
class LeaderboardViewModel: ObservableObject {
    var allUsers: [UserProfileModel] = []
    var currentUser: UserProfileModel
    
    init(currentUser: UserProfileModel) {
        self.currentUser = currentUser
        loadMockData()
    }
    
    func loadMockData() {
        allUsers = UserProfileModel.mockUsers(currentUser: currentUser)
    }
    
    var sortedUsers: [UserProfileModel] {
        allUsers.sorted { $0.score > $1.score }
    }
    
    func isCurrentUser(_ user: UserProfileModel) -> Bool {
        user.id == currentUser.id
    }
    
    func refresh() {
        if let index = allUsers.firstIndex(where: { $0.id == currentUser.id }) {
            allUsers[index] = currentUser
        }
    }
    
    // Fournit des données formatées pour la vue
    func userDisplayInfo(for user: UserProfileModel) -> (username: String, score: String, stats: String) {
        let username = user.username
        let score = "Score : \(user.score)"
        let stats = "🏆 \(user.wins) victoires · 🌞 \(user.dailyWins) daily"
        return (username, score, stats)
    }
}
