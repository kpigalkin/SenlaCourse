//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 29.03.2022.
//

import UIKit


final class CubeViewController: UIViewController {
    
    var buttonsAction = true

    let playingField = [
    "\u{02680}",
    "\u{02681}",
    "\u{02682}",
    "\u{02683}",
    "\u{02684}",
    "\u{02685}"
    ]
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(playingField[0], for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 100, weight: .medium)
        button.backgroundColor = .clear
        button.tag = 1
        return button
    }()
    lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle(playingField[1], for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 100, weight: .medium)
        button.backgroundColor = .clear
        button.tag = 2
        return button
    }()
    lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle(playingField[2], for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 100, weight: .medium)
        button.backgroundColor = .clear
        button.tag = 3
        return button
    }()
    lazy var button4: UIButton = {
        let button = UIButton()
        button.setTitle(playingField[3], for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 100, weight: .medium)
        button.backgroundColor = .clear
        button.tag = 4
        return button
    }()
    lazy var button5: UIButton = {
        let button = UIButton()
        button.setTitle(playingField[4], for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 100, weight: .medium)
        button.backgroundColor = .clear
        button.tag = 5
        return button
    }()
    lazy var button6: UIButton = {
        let button = UIButton()
        button.setTitle(playingField[5], for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 100, weight: .medium)
        button.backgroundColor = .clear
        button.tag = 6
        return button
    }()
    lazy var throwButton: UIButton = {
        let button = UIButton()
        button.setTitle("Throw a dice", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        button.addAction(UIAction() { [weak self] _ in
            if self!.buttonsAction {
                // default action: "play"
                self?.routeToDiceGameResult()
            } else {
                // "play again"
                self?.initialSettings()
            }
        }, for: .touchUpInside)
        button.backgroundColor = .brown
        button.layer.cornerRadius = 11
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        button2.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        button3.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        button4.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        button5.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        button6.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        throwButton.frame = CGRect(origin: .zero, size: .init(width: 180, height: 50))

        button.center = view.center
        button2.center = CGPoint(x: view.center.x - 90.0, y: view.center.y)
        button3.center = CGPoint(x: view.center.x + 90.0, y: view.center.y)
        button4.center = CGPoint(x: view.center.x - 90.0, y: view.center.y - 90.0 )
        button5.center = CGPoint(x: view.center.x + 90.0, y: view.center.y - 90.0)
        button6.center = CGPoint(x: view.center.x, y: view.center.y - 90.0)
        throwButton.center = CGPoint(x: view.center.x, y: view.center.y + 105.0)
    }
}

// default setup
private extension CubeViewController {
    func setupView() {
        view.backgroundColor = .systemYellow
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(button5)
        view.addSubview(button6)
        view.addSubview(throwButton)
    }
}


// Throwing a dice
private extension CubeViewController {
    
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
    
    func routeToDiceGameResult() {
        view.backgroundColor = .systemBlue
        throwButton.setTitle("Play again", for: .normal)
        buttonsAction = !buttonsAction
        diceRolling()
    }
    
    func initialSettings() {
        buttonsAction = !buttonsAction
        throwButton.setTitle("Throw a dice", for: .normal)
        viewDidLoad()
    }
    
}

