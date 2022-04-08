 //
//  SettingsViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 31.03.2022.
//
import UIKit

final class GameResultViewController: UIViewController {
    
    private var userLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 65, weight: .medium)
        return label
    }()
    
    private var computerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 65, weight: .medium)
        return label
    }()
    
    private lazy var againButton: UIButton = {
        let button = UIButton()
        button.setTitle("Again", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        button.addAction(UIAction() { [weak self] _ in
            self?.routeToPlayAgain()
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
        
        userLabel.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        userLabel.center = CGPoint(x: view.center.x, y: view.center.y + 10.0)

        computerLabel.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        computerLabel.center = CGPoint(x: view.center.x, y: view.center.y - 130.0)
        
        againButton.frame = CGRect(origin: .zero, size: .init(width: 120, height: 50))
        againButton.center = CGPoint(x: view.center.x, y: view.center.y + 115.0)
    }
}

private extension GameResultViewController {
    func setupView() {
        view.backgroundColor = .systemYellow
        userLabel.text = RockPaper.userChose
        computerLabel.text = RockPaper.computerChose
        title = printGameResultTitle(status: determinationWinner())
        view.addSubview(userLabel)
        view.addSubview(computerLabel)
        view.addSubview(againButton)
    }
    func routeToPlayAgain() {
        navigationController?.popToRootViewController(animated: false)
    }
    func determinationWinner() -> RockPaper.GameResult {
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
    func printGameResultTitle(status: RockPaper.GameResult) -> String? {
        switch RockPaper.languageStatus {
        case .eng:
            return RockPaper.englishLanguage[status]
        case .rus:
            return RockPaper.russianLanguage[status]
        }
    }
}


