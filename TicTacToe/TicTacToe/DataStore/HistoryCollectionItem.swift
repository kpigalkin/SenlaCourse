//
//  HistoryCollectionItem.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 13.04.2022.
//

import UIKit

struct HistoryCollectionItem: Hashable {
    
    let uuid = UUID()
        
    enum ItemType {
        case throwInfo(configuration: ThrowInfoConfiguration)
        case rockPaper(configuration: RockPaperContentConfiguration)
        case cubeGame(configuration: CubeGameConfiguration)
        case bestSet(configuration: BestSetConfiguration)
    }
    
    let content: ItemType
    
    init(content: ItemType) {
        self.content = content
    }
    
    static func == (lhs: HistoryCollectionItem, rhs: HistoryCollectionItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
//        hasher.combine(uuid)
    }
}

