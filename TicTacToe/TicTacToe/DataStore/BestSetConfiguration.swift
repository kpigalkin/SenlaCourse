//
//  BestSetConfiguration.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 21.04.2022.
//

import UIKit

struct BestSetConfiguration: UIContentConfiguration {

    let id: Int
    let bestSet: Int

    func makeContentView() -> UIView & UIContentView {
        BestSetContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> BestSetConfiguration {
        return self
    }
}

final class BestSetContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration

    private let bestSetLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 100, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "выиграно подряд"
        return label
    }()
    private let secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "в камень-ножницы-бумага"
        return label
    }()


    init(with contentConfiguration: BestSetConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubview(bestSetLabel)
        addSubview(descriptionLabel)
        addSubview(secondDescriptionLabel)
        makeConstraints()
        configure()
        backgroundColor = .lightText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? BestSetConfiguration else {
            return
        }
        bestSetLabel.text = String(content.bestSet)
    }

    private func makeConstraints() {
        bestSetLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        secondDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bestSetLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bestSetLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: bestSetLabel.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: bestSetLabel.bottomAnchor),
            
            secondDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            secondDescriptionLabel.centerXAnchor.constraint(equalTo: bestSetLabel.centerXAnchor)
        ])
    }
}

