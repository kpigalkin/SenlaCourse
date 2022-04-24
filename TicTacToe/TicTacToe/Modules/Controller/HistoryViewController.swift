//
//  HistoryViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 12.04.2022.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private weak var historyViewDelegate: HistoryViewDelegate?
    private let historyView = HistoryView()
    
    override func loadView() {
        view = historyView
        historyViewDelegate = historyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
    }
}

extension HistoryViewController: RockPaperDelegate {
    func sendRockPaperItem(_ item: HistoryOfRockPaper) {
        historyViewDelegate?.appendRockPaperItem(item)
        print("sendRockPaperItem")
    }
}

extension HistoryViewController: CubeGameDelegate {
    func sendCubeGameItem(_ item: HistoryOfCubeGame) {
        historyViewDelegate?.appendCubeGameItem(item)
        print("sendCubeGameItem")
    }
}



protocol RockPaperDelegate: AnyObject {
    func sendRockPaperItem(_ item: HistoryOfRockPaper)
}

protocol CubeGameDelegate: AnyObject {
    func sendCubeGameItem(_ item: HistoryOfCubeGame)
}

