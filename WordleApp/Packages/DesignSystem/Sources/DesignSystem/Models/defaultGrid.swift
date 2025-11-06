//
//  defaultGrid.swift
//  DesignSystem
//
//  Created by LETARD Pierric on 05/11/2025.
//
import SwiftUI

@MainActor public let defautlGrid: [[LetterTile]] = [
    [
        LetterTile(id: 0, letter: "S", result: .correct),
        LetterTile(id: 1, letter: "W", result: .correct),
        LetterTile(id: 2, letter: "I", result: .empty),
        LetterTile(id: 3, letter: "F", result: .empty),
        LetterTile(id: 4, letter: "T", result: .correct)
    ],
    [
        LetterTile(id: 5, letter: "A", result: .empty),
        LetterTile(id: 6, letter: "P", result: .empty),
        LetterTile(id: 7, letter: "P", result: .empty),
        LetterTile(id: 8, letter: "L", result: .empty),
        LetterTile(id: 9, letter: "E", result: .misplaced)
    ]
]
