//
//  HistoryViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 12.04.2022.
//

import UIKit

class HistoryViewController: UIViewController {
    
    weak var historyViewDelegate: HistoryViewDelegate?
    private let historyView = HistoryView()
    
    override func loadView() {
        view = historyView
        
        historyViewDelegate = historyView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension HistoryViewController: RockPaperDelegate {
    
    func sendRockPaperItem(_ item: HistoryOfRockPaper) {
        historyViewDelegate = historyView
        historyViewDelegate?.appendRockPaperItem(item)
    }
}

extension HistoryViewController: CubeGameDelegate {
    
    func sendCubeGameItem(_ item: HistoryOfCubeGame) {
        historyViewDelegate = historyView
        historyViewDelegate?.appendCubeGameItem(item)
    }
}



protocol RockPaperDelegate: AnyObject {
    func sendRockPaperItem(_ item: HistoryOfRockPaper)
}
protocol CubeGameDelegate: AnyObject {
    func sendCubeGameItem(_ item: HistoryOfCubeGame)
}

