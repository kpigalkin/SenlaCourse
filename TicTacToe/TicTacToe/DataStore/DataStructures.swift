//
//  DataStore.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 13.04.2022.
//

import UIKit

struct HistoryOfRockPaper {
    let id: Int
    let gameStatus: String
    let computerChose: String
    let userChose: String
}
struct HistoryOfCubeGame {
    let id: Int
    let randomCube: String
}
struct ThrowInfo {
    var id: Int
    var data: [String]
}
struct BestRockPaperSet {
    let id: Int
    var bestSet: Int
}
