//
//  Game.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 29.03.2022.
//

import UIKit

var languageSCStoreIndex = 0
var drawModeStatusSCStoreIndex = 0

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


struct RockPaper {
    
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
func printGameResultTitle(status: GameResult) -> String? {
    switch RockPaper.languageStatus {
    case .eng:
        return RockPaper.englishLanguage[status]
    case .rus:
        return RockPaper.russianLanguage[status]
    }
}

func changeLanguage() {
    switch RockPaper.languageStatus {
    case .eng:
        RockPaper.languageStatus = .rus
    case .rus:
        RockPaper.languageStatus = .eng
    }
}

func changeDrawMode() {
    RockPaper.drawModeStatus = !RockPaper.drawModeStatus
}

func determinationWinner() -> GameResult {
    let user = RockPaper.userChose
    let computer = RockPaper.computerChose
    
    if computer == user {return .draw}
    
    if computer == "✂️" && user == "🗿" {return .win}
    if computer == "✂️" && user == "🧻" {return .lose}

    if computer == "🧻" && user == "✂️" {return .win}
    if computer == "🧻" && user == "🗿" {return .lose}

    if computer == "🗿" && user == "🧻" {return .win}
    if computer == "🗿" && user == "✂️" {return .lose}
    
    return .defaultStatus
}




