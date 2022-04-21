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
        
        let navCTicTac = NavigationController(
            rootViewController: CubeViewController()
        )
        let navCRockPaper = NavigationController(
            rootViewController: RockPaperViewController()
        )
        let navCHistory = NavigationController(
            rootViewController: HistoryViewController()
        )

        
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 23, weight: .heavy
        )
        
        
        navCTicTac.tabBarItem = UITabBarItem(
            title: "Cube",
            image: UIImage(
                systemName: "cube"
            ),
            tag: 0
        )
        navCTicTac.tabBarItem.selectedImage = UIImage(systemName: "cube.fill", withConfiguration: configuration)
        
        
        navCRockPaper.tabBarItem = UITabBarItem(
            title: "RockPaperScissors",
            image: UIImage(
                systemName: "gamecontroller"
            ),
            tag: 1
        )
        navCRockPaper.tabBarItem.selectedImage = UIImage(systemName: "gamecontroller.fill", withConfiguration: configuration)
        
        navCHistory.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(
            systemName: "clock"
            ),
            tag: 2
        )
        navCHistory.tabBarItem.selectedImage = UIImage(systemName: "clock.fill", withConfiguration: configuration)
        
        
        setViewControllers(
            [navCRockPaper, navCTicTac, navCHistory],
            animated: false
        )
    }
}

