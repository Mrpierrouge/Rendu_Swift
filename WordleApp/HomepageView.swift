//
//  HomepageView.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//
import SwiftUI
import DesignSystem

struct WordleHomePageView: View {
    init() {
        let user = UserProfileModel()
        _currentUser = StateObject(wrappedValue: user)
        _wordleGame = StateObject(wrappedValue:WordleGameViewModel(currentUser: user))
        _dailyGame = StateObject(wrappedValue:WordleGameViewModel(currentUser: user))
    }
    @StateObject var currentUser: UserProfileModel
    @StateObject var wordleGame: WordleGameViewModel
    @StateObject var dailyGame: WordleGameViewModel
    @State private var navigationDestination: HomeDestination? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("Wordle")
                    .font(.largeTitle.bold())
                    .padding(.top, 40)
                
                WordGridView(rows: defautlGrid)
                    .padding(.horizontal)
                    .frame(maxHeight: 300)
                    .opacity(0.7)
                
                Spacer()
                
                AppButtonView(title: "dailyGameButton"){
                    dailyGame.startNewGame(daily: true)
                    navigationDestination = .dailyGame
                }
                AppButtonView(title:"playButton") {
                    wordleGame.startNewGame(daily: false)
                    navigationDestination = .normalGame
                }
                AppButtonView(title: "Leaderboard") {
                    navigationDestination = .leaderboard
                }
            }
            
            .navigationDestination(item: $navigationDestination) { destination in
                switch destination {
                case .dailyGame:
                    WordleGameView(gameModel: dailyGame)
                case .normalGame:
                    WordleGameView(gameModel: wordleGame)
                case .leaderboard:
                    LeaderboardView(currentUser: currentUser)
                }
            }
            
            .task {
                if wordleGame.words.isEmpty {
                    //Je fetch les mots 50 par 50 pour réduire le nombre de connexion. J'utilise ensuite les mots dans une liste locale
                    wordleGame.words = await wordleGame.getWord(count: 50)
                }
                if dailyGame.dailyWord == "" {
                    dailyGame.dailyWord = await dailyGame.getDailyWord()
                }
            }
        }
    }
}
