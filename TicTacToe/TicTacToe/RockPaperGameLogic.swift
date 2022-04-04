//
//  RockPaperGameLogic.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 29.03.2022.
//

import UIKit

struct RockPaper {
    
    enum Language: String {
        case eng, rus
    }
    
    enum GameResult {
        case win, lose, draw, defaultStatus
    }

    enum ItemsEnum: String {
        case rock = "🗿"
        case paper = "🧻"
        case scissors = "✂️"
        
        static func random(drawMode: Bool) -> ItemsEnum.RawValue {
            let all: [ItemsEnum] = [
                .rock,
                .paper,
                .scissors,
            ]
            var randomIndex = Int(arc4random()) % all.count
            // drawmode condition
            while all[randomIndex].rawValue == RockPaper.userChose && drawMode == false
                {
                randomIndex = Int(arc4random()) % all.count
                }
            return all[randomIndex].rawValue
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







