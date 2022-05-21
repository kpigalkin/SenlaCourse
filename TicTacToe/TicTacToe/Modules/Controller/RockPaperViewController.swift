//
 //  RockPaperViewController.swift
 //  TicTacToe
 //
 //  Created by Кирилл Пигалкин on 29.03.2022.
 //

 import UIKit


 final class RockPaperViewController: UIViewController {
     
     weak var dataDelegate: RockPaperDelegate?
     
     var startView = UIView()
     let resultView = UIView()
     
     private lazy var button: UIButton = {
         let button = UIButton()
         button.setTitle("🗿", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 65, weight: .medium)
         button.addAction(UIAction() { [weak self] _ in
             self?.routeToGameResult(button: self!.button)
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
     
    // ... GameResult
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
             withConfiguration: UIImage.SymbolConfiguration(pointSize: 32)),
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
         GameLogic.userChose = button.titleLabel!.text!
         GameLogic.computerChose = GameLogic.ItemsEnum.random(drawMode: GameLogic.drawModeStatus)
         // Сохраняем старую view
         startView = self.view

         // Подменяем старую на новую view
         setupGameResultView()
         self.view = resultView
     }

     func routeToSettings() {
         let vc = SettingsViewController()
         navigationController?.pushViewController(vc, animated: true)
     }


 }

// Game result screen
private extension RockPaperViewController {

    func setupGameResultView() {
        
        resultView.backgroundColor = .systemYellow
        resultView.center = view.center
        resultView.frame = view.frame
        
        userLabel.text = GameLogic.userChose
        computerLabel.text = GameLogic.computerChose
        title = printGameResultTitle(status: determinationWinner())
        
        resultView.addSubview(userLabel)
        resultView.addSubview(computerLabel)
        resultView.addSubview(againButton)
        
        userLabel.frame = CGRect(origin: .zero, size: .init(
            width: 90,
            height: 90))
        userLabel.center = CGPoint(x: view.center.x, y: view.center.y + 10.0)

        computerLabel.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
        computerLabel.center = CGPoint(x: view.center.x, y: view.center.y - 130.0)

        againButton.frame = CGRect(origin: .zero, size: .init(width: 120, height: 50))
        againButton.center = CGPoint(x: view.center.x, y: view.center.y + 115.0)
        
        winSetCounter(gameStatus: title!)
        sendingItemToCollection()
    }
    
    // Appending elements in array named historyOfRockPaper.
    func sendingItemToCollection() {
        let item = HistoryOfRockPaper(
            id: GameLogic.getRockPaperIndex,
            gameStatus: title ?? "title",
            computerChose: GameLogic.computerChose,
            userChose: GameLogic.userChose)
        
        self.dataDelegate?.sendRockPaperItem(item)
    }
            
    func winSetCounter(gameStatus: String) {
        if (gameStatus == GameLogic.russianLanguage[.win] ||
            gameStatus == GameLogic.englishLanguage[.win]) {
            GameLogic.currentWinSet += 1
            } else {
                GameLogic.currentWinSet = 0
            }
            
        if GameLogic.currentWinSet > GameLogic.bestSet.bestSet {
            GameLogic.bestSet.bestSet = GameLogic.currentWinSet
        }
    }
    
    func routeToPlayAgain() {
        // Заменить новую view на старую
        self.view = startView
        title = "Rock-Paper-Scissors"
    }
    
    func determinationWinner() -> GameLogic.GameResult {
        let user = GameLogic.userChose
        let computer = GameLogic.computerChose

        if computer == user {return .draw}

        if computer == "✂️" && user == "🗿" {return .win}
        if computer == "✂️" && user == "🧻" {return .lose}

        if computer == "🧻" && user == "✂️" {return .win}
        if computer == "🧻" && user == "🗿" {return .lose}

        if computer == "🗿" && user == "🧻" {return .win}
        if computer == "🗿" && user == "✂️" {return .lose}
        
        return .defaultStatus
    }
    func printGameResultTitle(status: GameLogic.GameResult) -> String? {
        switch GameLogic.languageStatus {
        case .eng:
            return GameLogic.englishLanguage[status]
        case .rus:
            return GameLogic.russianLanguage[status]
        }
    }
}
