//
//  LetterTileModel.swift
//  DesignSystem
//
//  Created by LETARD Pierric on 04/11/2025.
//

import SwiftUI

public enum LetterResult: String, Codable {
    case correct
    case misplaced
    case wrong
    case empty
}

public struct LetterTile: Codable, Identifiable {
    public init(id: Int, letter: String?, result: LetterResult) {
        self.id = id
        self.letter = letter
        self.result = result
    }
    
    public let id: Int
    public var letter: String?
    public var result: LetterResult
    public var color: Color {
        switch result {
        case .correct: return .green
        case .misplaced: return .yellow
        case .wrong: return .red
        case .empty: return .gray
        }
    }
}
