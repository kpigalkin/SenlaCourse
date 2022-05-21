import UIKit


 final class CubeViewController: UIViewController {
     
     weak var dataDelegate: CubeGameDelegate?

     private var buttonsAction = true

     private let playingField = [
         "\u{02680}",
         "\u{02681}",
         "\u{02682}",
         "\u{02683}",
         "\u{02684}",
         "\u{02685}"
     ]
     private var throwStatistics = [
        "\u{02680}" : 0.0,
        "\u{02681}" : 0.0,
        "\u{02682}" : 0.0,
        "\u{02683}" : 0.0,
        "\u{02684}" : 0.0,
        "\u{02685}" : 0.0
     ]
     private var throwPercentage = [
        "\u{02680}" : 0.0,
        "\u{02681}" : 0.0,
        "\u{02682}" : 0.0,
        "\u{02683}" : 0.0,
        "\u{02684}" : 0.0,
        "\u{02685}" : 0.0
     ]
     
     var numberOfThrowing = 0.0
     
     
     lazy var cubeSide1: UILabel = {
         let title = UILabel()
         title.text = playingField[0]
         title.textColor = .white
         title.textAlignment = .center
         title.font = .systemFont(ofSize: 130, weight: .medium)
         title.backgroundColor = .clear
         return title
     }()
     lazy var cubeSide2: UILabel = {
         let title = UILabel()
         title.text = playingField[1]
         title.textColor = .white
         title.textAlignment = .center
         title.font = .systemFont(ofSize: 130, weight: .medium)
         title.backgroundColor = .clear
         return title
     }()
     lazy var cubeSide3: UILabel = {
         let title = UILabel()
         title.text = playingField[2]
         title.textColor = .white
         title.textAlignment = .center
         title.font = .systemFont(ofSize: 130, weight: .medium)
         title.backgroundColor = .clear
         return title
     }()
     lazy var cubeSide4: UILabel = {
         let title = UILabel()
         title.text = playingField[3]
         title.textColor = .white
         title.textAlignment = .center
         title.font = .systemFont(ofSize: 130, weight: .medium)
         title.backgroundColor = .clear
         return title
     }()
     lazy var cubeSide5: UILabel = {
         let title = UILabel()
         title.text = playingField[4]
         title.textColor = .white
         title.textAlignment = .center
         title.font = .systemFont(ofSize: 130, weight: .medium)
         title.backgroundColor = .clear
         return title
     }()
     lazy var cubeSide6: UILabel = {
         let title = UILabel()
         title.text = playingField[5]
         title.textColor = .white
         title.textAlignment = .center
         title.font = .systemFont(ofSize: 130, weight: .medium)
         title.backgroundColor = .clear
         return title
     }()
     
     
     lazy var throwButton: UIButton = {
         let button = UIButton()
         button.setTitle("Throw a dice", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
         button.addAction(UIAction() { [weak self] _ in
             self?.buttonConditionOfAction()
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
         cubeSide1.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
         cubeSide2.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
         cubeSide3.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
         cubeSide4.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
         cubeSide5.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
         cubeSide6.frame = CGRect(origin: .zero, size: .init(width: 90, height: 90))
         throwButton.frame = CGRect(origin: .zero, size: .init(width: 180, height: 50))

         cubeSide1.center = view.center
         cubeSide2.center = CGPoint(x: view.center.x - 90.0, y: view.center.y)
         cubeSide3.center = CGPoint(x: view.center.x + 90.0, y: view.center.y)
         cubeSide4.center = CGPoint(x: view.center.x - 90.0, y: view.center.y - 90.0 )
         cubeSide5.center = CGPoint(x: view.center.x + 90.0, y: view.center.y - 90.0)
         cubeSide6.center = CGPoint(x: view.center.x, y: view.center.y - 90.0)
         throwButton.center = CGPoint(x: view.center.x, y: view.center.y + 105.0)
     }
 }

 // default setup
 private extension CubeViewController {
     func setupView() {
         view.backgroundColor = .systemYellow
         view.addSubview(cubeSide1)
         view.addSubview(cubeSide2)
         view.addSubview(cubeSide3)
         view.addSubview(cubeSide4)
         view.addSubview(cubeSide5)
         view.addSubview(cubeSide6)
         view.addSubview(throwButton)
     }
 }


 // Throwing a dice
 private extension CubeViewController {

     func diceRolling() {
         let buttons = [
            cubeSide1, cubeSide2, cubeSide3,
            cubeSide4, cubeSide5, cubeSide6
         ]
         let randomButton = buttons.randomElement() ?? cubeSide1
         buttons.forEach(){
             if $0 != randomButton {$0.removeFromSuperview()}
         }
         
         // history of CubeGame (3rd section)
         let cubeSide = HistoryOfCubeGame(
            id: GameLogic.getCubeGameIndex,
            randomCube: randomButton.text ?? "unknowed")
         
         // statistics for HistoryView (1st section)
         fillingStatistics(sideOfCube: (randomButton.text)!)
         
         dataDelegate?.sendCubeGameItem(cubeSide)
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
     func buttonConditionOfAction() {
         if buttonsAction {
             // default action: "play"
             routeToDiceGameResult()
         } else {
             // "play again"
             initialSettings()
         }
     }
     func fillingStatistics(sideOfCube: String) {
         
         // First section - persentage of throwing.
         numberOfThrowing += 1
         throwStatistics[sideOfCube]! += 1
         
         Array(throwPercentage.keys).forEach { key in
             throwPercentage[key]! = (throwStatistics[key]! / numberOfThrowing * 100).rounded()
         }
         
         var newData = [String]()
         throwPercentage.forEach { statistic in
             let stringInCollection = statistic.key + String(statistic.value)
             newData.append(stringInCollection)
         }
         GameLogic.throwInfo.data = newData
     }
 }
