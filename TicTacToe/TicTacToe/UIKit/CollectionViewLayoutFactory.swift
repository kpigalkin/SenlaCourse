//
//  CollectionViewLayoutFactory.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 13.04.2022.
//

import UIKit

public enum CollectionViewLayoutFactory {
    
    static func historyFeedLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = Section.init(rawValue: sectionIndex) else {
                fatalError("Section layout is not implemented :(")
            }
            switch section {
            case .generalInfo:
                return CollectionViewLayoutFactory.createGeneralInfoSectionLayout()
            case .rockPaper:
                return CollectionViewLayoutFactory.createHistoryRockPaperSectionLayout()
            case .cubeGame:
                return CollectionViewLayoutFactory.createHistoryCubeSectionLayout()
            }
        }
        return layout
    }
}


private extension CollectionViewLayoutFactory {
    
    static func createHistoryRockPaperSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(70)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(
            top: 0,
            leading: 0,
            bottom: 5,
            trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.accessibilityScroll(.down)
        
        return section
    }
    
    static func createHistoryCubeSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .fractionalHeight(1.0)
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(
            top: 0,
            leading: 1,
            bottom: 2,
            trailing: 1)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 0,
            bottom: 0,
            trailing: 0)
        section.accessibilityScroll(.previous)
        return section
    }
    
    static func createGeneralInfoSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(230)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0,
            bottom: 2, trailing: 0)
        
        return section
    }
}
