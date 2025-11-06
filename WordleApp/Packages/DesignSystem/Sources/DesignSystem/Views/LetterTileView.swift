//
//  LetterTileView.swift
//  DesignSystem
//
//  Created by LETARD Pierric on 04/11/2025.
//
import SwiftUI

public struct LetterTileView: View {
    public init(letterTile: LetterTile, size: CGFloat = 50) {
        self.letterTile = letterTile
        self.size = size
    }
    let size: CGFloat
    let letterTile: LetterTile
    
    public var body: some View {
        Text(letterTile.letter ?? "")
            .frame(width: size, height: size)
            .background(letterTile.color)
            .cornerRadius(8)
            .font(.system(size: min(size * 0.6, 28), weight: .bold))
    }
    
}





