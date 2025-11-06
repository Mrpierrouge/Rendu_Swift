//
//  UserProfileModel.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//

import SwiftUI

@Observable
class UserProfileModel: Identifiable, ObservableObject {
    let id = UUID()
    var username: String = "Jean Dupont"
    var avatarImage: UIImage? = nil
    var wins: Int = 0
    var dailyWins: Int = 0
    var losses: Int = 0
    var score: Int {
        wins + (dailyWins * 2) - losses
    }
    
    static func mockUsers(currentUser: UserProfileModel) -> [UserProfileModel] {
        let user1 = UserProfileModel()
        user1.username = "Alice"
        user1.wins = 12
        user1.losses = 5
        user1.dailyWins = 4
        
        let user2 = UserProfileModel()
        user2.username = "Bob"
        user2.wins = 8
        user2.losses = 3
        user2.dailyWins = 1
        
        let user3 = UserProfileModel()
        user3.username = "Charlie"
        user3.wins = 15
        user3.losses = 7
        user3.dailyWins = 6
        
        return [currentUser, user1, user2, user3]
    }
}
