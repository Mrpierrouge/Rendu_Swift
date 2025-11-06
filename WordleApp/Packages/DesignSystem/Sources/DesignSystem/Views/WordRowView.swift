//
//  WordRowView.swift
//  DesignSystem
//
//  Created by LETARD Pierric on 05/11/2025.
//

import SwiftUI

public struct WordRowView: View {
    public init(tiles: [LetterTile], size: CGFloat) {
        self.tiles = tiles
        self.size = size
    }
    
    let tiles: [LetterTile]
    private let size: CGFloat
    
    public var body: some View {
        GridRow {
            ForEach(tiles) { tile in
                LetterTileView(letterTile: tile, size: size)
            }
        }
        
    }
}
