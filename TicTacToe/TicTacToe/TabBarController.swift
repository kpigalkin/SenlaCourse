//
//  TabBarController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 28.03.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isOpaque = false
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .systemGray6
        setupTabBar()
    }

}

private extension TabBarController {
    
    func setupTabBar() {
        print("⭕️ setupTabBar")
        // setup CleanHistoryViewController
        let viewController = CleanHistoryVC()
        let interactor = CleanInteractor()
        let presenter = CleanPresenter()
        let router = CleanRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        //
        let historyView = HistoryView()
//        let cleanHistoryVC = CleanHistoryVC()
        
        viewController.view = historyView
        viewController.historyView = historyView
        
//        let router = CleanRouter()
        let rspVC = RockPaperViewController()
        let cubeVC = CubeViewController()

        rspVC.dataDelegate = router
        cubeVC.dataDelegate = router
        
        let navCTicTac = NavigationController(rootViewController: cubeVC)
        let navCRockPaper = NavigationController(rootViewController: rspVC)
        let navCHistory = NavigationController(rootViewController: viewController)
        let navCAnimation = NavigationController(rootViewController: AnimationViewController())

        
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 23, weight: .heavy)
        
        navCTicTac.tabBarItem = UITabBarItem(
            title: "Cube",
            image: UIImage(
                systemName: "cube"
            ),
            tag: 0)
        navCTicTac.tabBarItem.selectedImage = UIImage(systemName: "cube.fill", withConfiguration: configuration)
        
        
        navCRockPaper.tabBarItem = UITabBarItem(
            title: "RockPaperScissors",
            image: UIImage(
                systemName: "gamecontroller"
            ),
            tag: 1)
        navCRockPaper.tabBarItem.selectedImage = UIImage(systemName: "gamecontroller.fill", withConfiguration: configuration)
        
        navCHistory.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(
            systemName: "clock"
            ),
            tag: 2)
        navCHistory.tabBarItem.selectedImage = UIImage(systemName: "clock.fill", withConfiguration: configuration)
        
        navCAnimation.tabBarItem = UITabBarItem(
            title: "Animation",
            image: UIImage(
            systemName: "bolt.horizontal.circle"
            ),
            tag: 3)
        navCAnimation.tabBarItem.selectedImage = UIImage(systemName: "bolt.horizontal.circle.fill", withConfiguration: configuration)
        
        
        setViewControllers(
            [navCRockPaper, navCTicTac, navCHistory, navCAnimation],
            animated: false)
    }
}

