//
//  CubeConfiguration.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 15.04.2022.
//

import UIKit

struct CubeGameConfiguration: UIContentConfiguration {

    let id: Int
    let randomCube: String

    func makeContentView() -> UIView & UIContentView {
        CubeContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> CubeGameConfiguration {
        return self
    }
}

final class CubeContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration

    private let randomCube: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()


    init(with contentConfiguration: CubeGameConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubview(randomCube)
        makeConstraints()
        configure()
        backgroundColor = .lightText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? CubeGameConfiguration else {
            return
        }
        randomCube.text = content.randomCube
    }

    private func makeConstraints() {
        randomCube.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            randomCube.centerXAnchor.constraint(equalTo: centerXAnchor),
            randomCube.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

