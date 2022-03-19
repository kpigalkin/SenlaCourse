 //
//  SettingsViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 31.03.2022.
//
import UIKit

class GameResultViewController: UIViewController {
    
    private lazy var userButton: UIButton = {
        let button = UIButton()
        button.setTitle(RockPaper.userChose, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 65, weight: .medium)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 40
        return button
    }()
    
    private lazy var computerButton: UIButton = {
        let button = UIButton()
        button.setTitle(ItemsEnum.random(drawMode: RockPaper.drawModeStatus), for: .normal)
        RockPaper.computerChose = button.titleLabel?.text ?? ""
        button.titleLabel?.font = .systemFont(ofSize: 65, weight: .medium)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 40
        return button
    }()
    
    private lazy var againButton: UIButton = {
        let button = UIButton()
        button.setTitle("Again", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        button.addAction(UIAction() { [weak self] _ in
            
            self?.routeToPlayAgain()
            RockPaper.userChose = button.titleLabel!.text!
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
        userButton.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        computerButton.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        computerButton.center = CGPoint(x: view.center.x, y: view.center.y - 130.0)
        userButton.center = CGPoint(x: view.center.x, y: view.center.y + 10.0)
        
        againButton.frame = CGRect(origin: .zero, size: .init(width: 120, height: 50))
        againButton.center = CGPoint(x: view.center.x, y: view.center.y + 115.0)
    }
}

private extension GameResultViewController {
    func setupView() {
        view.backgroundColor = .systemYellow
        computerButton.titleLabel?.text = ItemsEnum.random(drawMode: RockPaper.drawModeStatus)
        title = printGameResultTitle(status: determinationWinner())
        view.addSubview(userButton)
        view.addSubview(computerButton)
        view.addSubview(againButton)
    }
    func routeToPlayAgain() {
        navigationController?.popToRootViewController(animated: false)
    }
}


