//
//  DiceGameViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 31.03.2022.
//

import UIKit

class CubeGameResultViewController: CubeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension CubeGameResultViewController {
    
    func routeToPlayAgain() {
        navigationController?.popToRootViewController(animated: false)
    }
    func setupView() {
        view.backgroundColor = .systemBlue
        throwButton.setTitle("Again", for: .normal)
        throwButton.addAction(UIAction() { [weak self] _ in
            self?.routeToPlayAgain()
            }, for: .touchUpInside)
        diceRolling()
    }
    func diceRolling() {
        let buttons = [
        button, button2, button3,
        button4, button5, button6
        ]
        let tag = Int.random(in: 1..<7)
        
        for item in buttons {
            if item.tag != tag {item.removeFromSuperview()}
        }
    }
}
