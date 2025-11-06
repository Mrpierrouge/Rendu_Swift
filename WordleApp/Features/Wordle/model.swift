//
//  model.swift
//  cours1
//
//  Created by LETARD Pierric on 04/11/2025.
//
import SwiftUI
import DesignSystem

struct MotRandom: Codable, Identifiable {
    let id = UUID()
    let name: String
    let categorie: String
}

struct Game {
    let targetWord: String
    var grid: [[LetterTile]]
    var currentRowIndex: Int = 0
    var currentAttempt: WordAttempt {
        WordAttempt(tiles: grid[currentRowIndex])
    }
    var isOver: Bool = false
    var hasWon: Bool = false
}

struct WordAttempt {
    var tiles: [LetterTile]
    var currentWord: String {
        tiles.compactMap { $0.letter }.joined()
    }
    var isComplete: Bool {
        tiles.allSatisfy { $0.letter != nil }
    }
    var firstEmptyIndex: Int? {
        tiles.firstIndex(where: { $0.letter == nil })
    }
}

enum HomeDestination: Hashable, Identifiable {
    case dailyGame
    case normalGame
    case leaderboard
    
    var id: Self { self }
}
