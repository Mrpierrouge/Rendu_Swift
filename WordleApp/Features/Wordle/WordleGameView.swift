//
//  WordleGameView.swift
//  cours1
//
//  Created by LETARD Pierric on 05/11/2025.
//


import SwiftUI
import DesignSystem

public struct WordleGameView: View {
    init(gameModel: WordleGameViewModel = WordleGameViewModel()) {
        self.gameModel = gameModel
    }
    @ObservedObject var gameModel: WordleGameViewModel
    
    public var body: some View {
        WordGridView(rows: gameModel.currentGame?.grid ?? defautlGrid)
            .padding(.top, 16)
            .padding(.horizontal)
            .frame(maxHeight: 380)
        
        Spacer(minLength: 10)
        
        Text(gameModel.message)
        if gameModel.currentGame?.isOver == true {
            AppButtonView(title: "replayButton") {
                gameModel.startNewGame()
            }
        }

        KeyboardView(keys: gameModel.keyboard) { key in
            gameModel.tap(key: key)
        }
        .padding(.bottom, 8)
        .navigationTitle("Wordle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
