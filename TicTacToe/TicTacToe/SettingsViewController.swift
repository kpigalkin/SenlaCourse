//
//  SettingsViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 31.03.2022.
//
import UIKit



class SettingsViewController: UIViewController {
    
    let items = ["RUSSIAN", "ENGLISH"]
    let drawModeStatus = ["OFF DRAWMODE", "ON DRAWMODE"]
    
    
    private lazy var languageSC: UISegmentedControl = {
        let languageSC = UISegmentedControl(items: items)
        languageSC.selectedSegmentIndex = languageSCStoreIndex
        languageSC.selectedSegmentTintColor = .systemYellow
        languageSC.addAction(UIAction() { [self]_ in
            print("languageSC.selectedSegmentIndex - \(languageSC.selectedSegmentIndex)")
            languageSCStoreIndex = languageSC.selectedSegmentIndex
            changeLanguage()
        }, for: .valueChanged)
        return languageSC
    }()
    
    private lazy var drawModeStatusSC: UISegmentedControl = {
        let drawModeStatusSC = UISegmentedControl(items: drawModeStatus)
        drawModeStatusSC.selectedSegmentIndex = drawModeStatusSCStoreIndex
        drawModeStatusSC.selectedSegmentTintColor = .systemYellow
        drawModeStatusSC.addAction(UIAction() { [self]_ in
            drawModeStatusSCStoreIndex = drawModeStatusSC.selectedSegmentIndex
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
}


/////////////...
