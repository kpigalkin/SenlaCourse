//
//  OrdinaryContentConfiguration.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 13.04.2022.
//

import UIKit

struct RockPaperContentConfiguration: UIContentConfiguration {
    
    let id: Int
    let gameStatus: String
    let computerChose: String
    let userChose: String
    
    func makeContentView() -> UIView & UIContentView {
        RockPaperContentView(with: self)
    }
    
    func updated(for state: UIConfigurationState) -> RockPaperContentConfiguration {
        return self
    }
}

final class RockPaperContentView: UIView, UIContentView {
    
    var configuration: UIContentConfiguration
    
    private let gameStatus: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let userChose: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let computerChose: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let labelUser: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let labelComputer: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    
    init(with contentConfiguration: RockPaperContentConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubview(gameStatus)
        addSubview(userChose)
        addSubview(computerChose)
        addSubview(labelUser)
        addSubview(labelComputer)
        makeConstraints()
        configure()
        backgroundColor = .lightText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let content = configuration as? RockPaperContentConfiguration else {
            return
        }
        labelUser.text = "Ваш выбор"
        labelComputer.text = "Компьютер"
        userChose.text = content.userChose
        computerChose.text = content.computerChose
        gameStatus.text = content.gameStatus
    }
    
    private func makeConstraints() {
        gameStatus.translatesAutoresizingMaskIntoConstraints = false
        computerChose.translatesAutoresizingMaskIntoConstraints = false
        userChose.translatesAutoresizingMaskIntoConstraints = false
        labelUser.translatesAutoresizingMaskIntoConstraints = false
        labelComputer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameStatus.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameStatus.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            userChose.centerXAnchor.constraint(equalTo: gameStatus.centerXAnchor, constant: 100),
            userChose.centerYAnchor.constraint(
                equalTo: gameStatus.centerYAnchor),
            
            labelUser.leadingAnchor.constraint(equalTo: userChose.trailingAnchor, constant: 7),
            labelUser.centerYAnchor.constraint(
                equalTo: gameStatus.centerYAnchor),
            
            computerChose.centerXAnchor.constraint(equalTo: gameStatus.centerXAnchor, constant: -100),
            computerChose.centerYAnchor.constraint(
                equalTo: gameStatus.centerYAnchor),
            
            labelComputer.trailingAnchor.constraint(equalTo: computerChose.leadingAnchor, constant: -7),
            labelComputer.centerYAnchor.constraint(
                equalTo: gameStatus.centerYAnchor)
        ])
    }
}

