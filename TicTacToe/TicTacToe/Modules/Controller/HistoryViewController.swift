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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        historyViewDelegate = historyView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSnapshot()
    }
}
private extension HistoryViewController {
    private func updateSnapshot() {
        historyViewDelegate?.updateCollection()
    }
}

