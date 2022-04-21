//
//  RockPaperGameLogic.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 29.03.2022.
//

import UIKit

struct GameLogic {
    
    // Store data for HistoryView.
    static var historyOfRockPaper = [HistoryOfRockPaper]()
    static var getRockPaperIndex: Int {
        historyOfRockPaper.count
    }
    static var historyOfCubeGame = [HistoryOfCubeGame]()
    static var getCubeGameIndex: Int {
        historyOfCubeGame.count
    }
    static var throwInfo = ThrowInfo(id: 0, data: [])
    static var bestSet = BestRockPaperSet(id: 0, bestSet: 0)
    static var currentWinSet = 0

    
    
    enum Language: String {
        case eng, rus
    }

    enum GameResult {
        case win
        case lose
        case draw
        case defaultStatus
    }

    enum ItemsEnum: String, CaseIterable {
        case rock = "🗿"
        case paper = "🧻"
        case scissors = "✂️"

        static func random(drawMode: Bool) -> ItemsEnum.RawValue {

         var all = [String]()
         allCases.forEach() {
             all.append($0.rawValue)
         }
         if drawMode == false {
             all = all.filter {$0 != userChose}
         }
         return all.randomElement()!
         }
    }

    static var languageSCStoreIndex = 0
    static var drawModeStatusSCStoreIndex = 0
    
    static var computerChose: String = ""
    static var userChose: String = ""
    static var drawModeStatus = false
    static var languageStatus: Language = .rus

    static let englishLanguage: [GameResult : String] = [
        .defaultStatus: "Game result",
        .win: "You win!",
        .draw: "Draw",
        .lose: "You lose..."
    ]
    static let russianLanguage: [GameResult : String] = [
        .defaultStatus: "Результат игры",
        .win: "Вы выиграли!",
        .draw: "Ничья.",
        .lose: "Вы проиграли..."
    ]
}
