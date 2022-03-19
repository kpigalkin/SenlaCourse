//
//  RockPaperViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 29.03.2022.
//

import UIKit


class RockPaperViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("🗿", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 65, weight: .medium)
        button.addAction(UIAction() { [weak self] _ in
            self?.routeToGameResult(button: self!.button)
            RockPaper.userChose = button.titleLabel!.text!
            }, for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 40
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("✂️", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 65, weight: .medium)
        button.addAction(UIAction() { [weak self] _ in
            self?.routeToGameResult(button: self!.button2)
            }, for: .touchUpInside)

        button.backgroundColor = .clear
        button.layer.cornerRadius = 40
        return button
    }()
    
    private lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("🧻", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 65, weight: .medium)
        button.addAction(UIAction() { [weak self] _ in
            self?.routeToGameResult(button: self!.button3)
            }, for: .touchUpInside)

        button.backgroundColor = .clear
        button.layer.cornerRadius = 40
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarIfPossible()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        button2.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        button3.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))

        button.center = CGPoint(x: view.center.x - 130.0, y: view.center.y)
        button2.center = view.center
        button3.center = CGPoint(x: view.center.x + 130.0, y: view.center.y)
    }
}



private extension RockPaperViewController {

    func setupNavigationBarIfPossible() {

        title = "Rock-Paper-Scissors"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleVerticalPositionAdjustment(for: .defaultPrompt)
        let button = UIButton()
        button.setImage(
        UIImage(
            systemName: "gearshape.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32)
            ),
            for: .normal)
        button.imageView?.tintColor = .black
        button.addAction(UIAction() {
            [weak self] _ in self?.routeToSettings()
        },
            for: .touchUpInside)
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView: button) ]
     }

    func setupView() {
        view.backgroundColor = .systemYellow
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
    }
    
    func routeToGameResult(button: UIButton) {
        let vc = GameResultViewController()
        RockPaper.userChose = button.titleLabel!.text!
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func routeToSettings() {
        let vc = SettingsViewController()
        present(vc, animated: true)
    }
    

}


