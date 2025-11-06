//
//  KeyboardKey.swift
//  DesignSystem
//
//  Created by LETARD Pierric on 05/11/2025.
//

import SwiftUI

public enum KeyType {
    case letter(String)
    case enter
    case delete
}

public struct KeyboardKey: Identifiable {
    public init(type: KeyType, state: LetterResult) {
        self.type = type
        self.state = state
    }
    public let id = UUID()
    public let type: KeyType
    public var state: LetterResult
    public var color: Color {
        switch state {
        case .correct: return .green
        case .misplaced: return .yellow
        case .wrong: return .red
        case .empty: return .gray
        }
    }
}
