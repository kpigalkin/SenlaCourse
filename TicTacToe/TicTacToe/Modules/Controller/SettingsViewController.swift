//
 //  SettingsViewController.swift
 //  TicTacToe
 //
 //  Created by Кирилл Пигалкин on 31.03.2022.
 //
 import UIKit




 final class SettingsViewController: UIViewController {

     private let items = ["RUSSIAN", "ENGLISH"]
     private let drawModeStatus = ["OFF DRAWMODE", "ON DRAWMODE"]

     private lazy var languageSC: UISegmentedControl = {
         let languageSC = UISegmentedControl(items: items)
         languageSC.selectedSegmentIndex = GameLogic.languageSCStoreIndex
         languageSC.selectedSegmentTintColor = .systemYellow
         languageSC.addAction(UIAction() { [self]_ in
             GameLogic.languageSCStoreIndex = languageSC.selectedSegmentIndex
             changeLanguage()
         }, for: .valueChanged)
         return languageSC
     }()

     private lazy var drawModeStatusSC: UISegmentedControl = {
         let drawModeStatusSC = UISegmentedControl(items: drawModeStatus)
         drawModeStatusSC.selectedSegmentIndex = GameLogic.drawModeStatusSCStoreIndex
         drawModeStatusSC.selectedSegmentTintColor = .systemYellow
         drawModeStatusSC.addAction(UIAction() { [self]_ in
             GameLogic.drawModeStatusSCStoreIndex = drawModeStatusSC.selectedSegmentIndex
             changeDrawMode()
         }, for: .valueChanged)
         return drawModeStatusSC
     }()


     override func viewDidLoad() {
         super.viewDidLoad()
         setupView()
     }
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         languageSC.frame = CGRect(origin: .zero, size: .init(width: 270, height: 90))
         languageSC.center = CGPoint(x: view.center.x, y: view.center.y)
         drawModeStatusSC.frame = CGRect(origin: .zero, size: .init(width: 270, height: 90))
         drawModeStatusSC.center = CGPoint(x: view.center.x, y: view.center.y - 110.0)
     }
 }

 private extension SettingsViewController {
     func setupView() {
         view.backgroundColor = .systemGray6
         view.addSubview(languageSC)
         view.addSubview(drawModeStatusSC)
     }

     func changeLanguage() {
         switch GameLogic.languageStatus {
         case .eng:
             GameLogic.languageStatus = .rus
         case .rus:
             GameLogic.languageStatus = .eng
         }
     }

     func changeDrawMode() {
         GameLogic.drawModeStatus = !GameLogic.drawModeStatus
     }
 }
