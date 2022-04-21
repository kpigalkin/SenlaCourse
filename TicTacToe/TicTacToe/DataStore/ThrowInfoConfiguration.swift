//
//  CubeConfiguration.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 15.04.2022.
//

import UIKit

struct ThrowInfoConfiguration: UIContentConfiguration {
     
    var id: Int
    var data: [String]

    func makeContentView() -> UIView & UIContentView {
        ThrowInfoContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> ThrowInfoConfiguration {
        return self
    }
}

final class ThrowInfoContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration

    private let sideOfCube: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let sideOfCube2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let sideOfCube3: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let sideOfCube4: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let sideOfCube5: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let sideOfCube6: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()


    init(with contentConfiguration: ThrowInfoConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubview(sideOfCube)
        addSubview(sideOfCube2)
        addSubview(sideOfCube3)
        addSubview(sideOfCube4)
        addSubview(sideOfCube5)
        addSubview(sideOfCube6)
        makeConstraints()
        configure()
        backgroundColor = .lightText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let _ = configuration as? ThrowInfoConfiguration else {
            return
        }
        setupLabels()
        print("configure")
    }

    private func makeConstraints() {
        sideOfCube.translatesAutoresizingMaskIntoConstraints = false
        sideOfCube2.translatesAutoresizingMaskIntoConstraints = false
        sideOfCube3.translatesAutoresizingMaskIntoConstraints = false
        sideOfCube4.translatesAutoresizingMaskIntoConstraints = false
        sideOfCube5.translatesAutoresizingMaskIntoConstraints = false
        sideOfCube6.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideOfCube.centerXAnchor.constraint(equalTo: centerXAnchor),
            sideOfCube.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -17),
            
            sideOfCube2.leadingAnchor.constraint(equalTo: sideOfCube.leadingAnchor),
            sideOfCube2.bottomAnchor.constraint(equalTo: sideOfCube.topAnchor, constant: -10),

            sideOfCube3.leadingAnchor.constraint(equalTo: sideOfCube.leadingAnchor),
            sideOfCube3.bottomAnchor.constraint(equalTo: sideOfCube2.topAnchor ,constant: -10),
            
            sideOfCube4.leadingAnchor.constraint(equalTo: sideOfCube.leadingAnchor),
            sideOfCube4.topAnchor.constraint(equalTo: sideOfCube.bottomAnchor ,constant: 10),
            
            sideOfCube5.leadingAnchor.constraint(equalTo: sideOfCube.leadingAnchor),
            sideOfCube5.topAnchor.constraint(equalTo: sideOfCube4.bottomAnchor ,constant: 10),
            
            sideOfCube6.leadingAnchor.constraint(equalTo: sideOfCube.leadingAnchor),
            sideOfCube6.topAnchor.constraint(equalTo: sideOfCube5.bottomAnchor ,constant: 10),
        ])
    }
    
    
}
extension ThrowInfoContentView: ThrowInfoContentViewDelegate {
    internal func setupLabels() {
        if !GameLogic.throwInfo.data.isEmpty {
            let array = [
            sideOfCube, sideOfCube2, sideOfCube3,
            sideOfCube4, sideOfCube5, sideOfCube6
            ]
            array.forEach { label in
                let index = array.firstIndex(of: label)
                label.text = GameLogic.throwInfo.data[index!] + "%"
            }
            print("setupLabels")
            
        }
    }
}

