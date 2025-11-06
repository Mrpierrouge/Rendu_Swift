//
//  WordleViewModel.swift
//  cours1
//
//  Created by LETARD Pierric on 04/11/2025.
//

import SwiftUI
import DesignSystem


@Observable
class WordleGameViewModel: ObservableObject {
    var baseURL: String = "https://trouve-mot.fr/api/random"
    var message: String = ""
    var words: Array<MotRandom> = []
    var currentGame: Game? = nil
    var dailyWord: String = ""
    var keyStates: [String: LetterResult] = [:]
    
    var keyboard: [[KeyboardKey]] = [
        "QWERTYUIOP".map { KeyboardKey(type: .letter(String($0)), state: .empty) },
        "ASDFGHJKL".map { KeyboardKey(type: .letter(String($0)), state: .empty) },
        [KeyboardKey(type: .enter, state: .empty)]
        + "ZXCVBNM".map { KeyboardKey(type: .letter(String($0)), state: .empty) }
        + [KeyboardKey(type: .delete, state: .empty)]
    ]
    
    func getWord(count: Int = 1) async -> Array<MotRandom> {
        words.removeAll()
        guard let url = URL(string: baseURL + "/" + String(count)) else {
            return []
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return []
            }
            let decoded = try JSONDecoder().decode([MotRandom].self, from: data)
            return decoded
        } catch {
            print(error)
            return []
        }
    }
    func startNewGame(daily: Bool = false) {
        guard currentGame == nil || (currentGame?.isOver == true) else {
            return
        }
        // Je réassigne le clavier pour reset les couleurs
        keyboard = [
            "QWERTYUIOP".map { KeyboardKey(type: .letter(String($0)), state: .empty) },
            "ASDFGHJKL".map { KeyboardKey(type: .letter(String($0)), state: .empty) },
            [KeyboardKey(type: .enter, state: .empty)]
            + "ZXCVBNM".map { KeyboardKey(type: .letter(String($0)), state: .empty) }
            + [KeyboardKey(type: .delete, state: .empty)]
        ]
        message = ""
        var word = dailyWord.uppercased()
        if !daily {
            guard let first = words.first else { return }
            word = first.name.uppercased()
        }
        
        let emptyRow = (0..<word.count).map { i in
            LetterTile(id: i, letter: nil, result: .empty)
        }
        let grid = Array(repeating: emptyRow, count: 6)
        
        currentGame = Game(targetWord: word.folding(options: .diacriticInsensitive, locale: .current), grid: grid)
        print("Nouveau mot mystère :", word)
    }
    func getDailyWord() async -> String {
        guard let url = URL(string: "https://trouve-mot.fr/api/daily") else {
            return ""
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return ""
            }
            let decoded = try JSONDecoder().decode(MotRandom.self, from: data)
            return decoded.name
        } catch {
            print(error)
            return ""
        }
    }
    func insertLetter(letter: String){
        guard var game = currentGame else { return }
        guard !game.isOver else { return }
        
        let rowIndex = game.currentRowIndex
        guard let emptyIndex = game.grid[rowIndex].firstIndex(where: { $0.letter == nil }) else {
            return
        }
        
        game.grid[rowIndex][emptyIndex].letter = letter.uppercased()
        currentGame = game
    }
    func deleteLetter() {
        guard var game = currentGame else { return }
        guard !game.isOver else { return }
        
        let rowIndex = game.currentRowIndex
        
        if let lastFilled = game.grid[rowIndex].lastIndex(where: { $0.letter != nil }) {
            game.grid[rowIndex][lastFilled].letter = nil
            currentGame = game
        }
    }
    func tryWord() {
        guard var game = currentGame else { return }
        var rowIndex = game.currentRowIndex
        let attempt = game.currentAttempt
        
        guard attempt.isComplete else {
            print("Mot incomplet")
            return
        }
        let guess = attempt.currentWord
        let target = Array(game.targetWord.uppercased())
        var targetLetterCount: [Character: Int] = [:]
        
        for letter in target {
            targetLetterCount[letter, default: 0] += 1
        }
        
        // Ici on fait 2 boucles d'afflié pour pas que une lettre mal placée prenne la place d'une lettre bien placée dans le targetLetterCount.
        // On veux d'abord chercher les lettres bien placés et les enlever de targetLetterCount, ensuite sur celles restantes on vérifie si elle existe ailleurs dans le mot
        
        for i in 0..<target.count {
            let guessChar = Array(guess)[i]
            if guessChar == target[i] {
                game.grid[rowIndex][i].result = .correct
                targetLetterCount[guessChar]! -= 1
            }
        }
        
        for i in 0..<target.count {
            let guessChar = Array(guess)[i]
            if game.grid[rowIndex][i].result != .correct && targetLetterCount[guessChar] ?? 0 > 0{
                game.grid[rowIndex][i].result = .misplaced
                targetLetterCount[guessChar]! -= 1
            }
        }
        updateKeyboardColors(with: game.grid[rowIndex])
        
        if guess == game.targetWord.uppercased() {
            message = "Félicitation !"
            if dailyWord == "" {
                words.remove(at: 0)
                game.isOver = true
            }
        } else {
            if game.currentRowIndex + 1 < game.grid.count {
                game.currentRowIndex += 1
            } else {
                message = "Perdu ! le mot était " + game.targetWord
                if dailyWord == "" {
                    words.remove(at: 0)
                    game.isOver = true
                }
            }
        }
        
        
        
        currentGame = game
    }
    func tap(key: KeyboardKey) {
        switch key.type {
        case .letter(let l):
            insertLetter(letter: l)
        case .enter:
            tryWord()
        case .delete:
            deleteLetter()
            
        }
    }
    func updateKeyboardColors(with word: [LetterTile]) {
        for tile in word {
            guard let letter = tile.letter else { continue }
            for rowIndex in keyboard.indices {
                for keyIndex in keyboard[rowIndex].indices {
                    
                    switch keyboard[rowIndex][keyIndex].type {
                    case .letter(let l) where l == letter:
                        
                        let currentState = keyboard[rowIndex][keyIndex].state
                        if tile.result == .correct || currentState == .empty {
                            keyboard[rowIndex][keyIndex].state = tile.result
                            if tile.result == .empty {
                                keyboard[rowIndex][keyIndex].state = .wrong
                            }
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
}
