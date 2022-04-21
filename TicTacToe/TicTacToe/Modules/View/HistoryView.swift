//
//  HistoryView.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 12.04.2022.
//
import UIKit


enum Section: Int {

    case generalInfo
    case rockPaper
    case cubeGame
}

final class HistoryView: UIView {
    
    private lazy var dataSource = makeDataSource()

    private let rockPaperRegistration = UICollectionView.CellRegistration<UICollectionViewCell, RockPaperContentConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = itemIdentifier
    }
    private let cubeRegistration = UICollectionView.CellRegistration<UICollectionViewCell, CubeGameConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = itemIdentifier
    }
    private let throwInfoRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ThrowInfoConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = itemIdentifier
    }
    private let bestSetRegistration = UICollectionView.CellRegistration<UICollectionViewCell, BestSetConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = itemIdentifier
    }
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: CollectionViewLayoutFactory.historyFeedLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .systemYellow
        
        return view
    }()
    
    override init(frame: CGRect) {

        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        addSubviews()
        makeConstraints()
        createSnapshot()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension HistoryView {
    
    func addSubviews() {
        addSubview(collectionView)
    }
    
    func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HistoryCollectionItem>()
        
        snapshot.appendSections([.generalInfo, .rockPaper, .cubeGame])
        snapshot.appendItems([GameLogic.throwInfo].map({ feed in
                .init(content: .throwInfo(configuration: .init(
                    id: feed.id,
                    data: feed.data
                )))
        }), toSection: .generalInfo)
        snapshot.appendItems(GameLogic.historyOfRockPaper.map { feed in
            .init(content: .rockPaper(
                configuration: .init(
                    id: feed.id,
                    gameStatus: feed.gameStatus,
                    computerChose: feed.computerChose,
                    userChose: feed.userChose
                    )))
        }, toSection: .rockPaper)
        snapshot.appendItems(GameLogic.historyOfCubeGame.map { feed in
            .init(content: .cubeGame(
                configuration: .init(
                    id: feed.id,
                    randomCube: feed.randomCube
                    )))
            }, toSection: .cubeGame)
        snapshot.appendItems([GameLogic.bestSet].map({ feed in
                .init(content: .bestSet(configuration: .init(
                    id: feed.id,
                    bestSet: feed.bestSet)))
        }), toSection: .generalInfo)
        dataSource.apply(snapshot)
    }
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, HistoryCollectionItem> {
        let dataSource = UICollectionViewDiffableDataSource<Section, HistoryCollectionItem>(collectionView: collectionView) { [weak self] collectionView,
            indexPath, item in
            guard let self = self,
                let _ = self.dataSource.sectionIdentifier(for: indexPath.section) else {
                return .init(frame: .zero)
            }
            switch item.content {
            case .throwInfo(configuration: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.throwInfoRegistration, for: indexPath, item: configuration)
            case .rockPaper(configuration: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.rockPaperRegistration, for: indexPath, item: configuration)
            case .cubeGame(configuration: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.cubeRegistration, for: indexPath, item: configuration)
            case .bestSet(configuration: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.bestSetRegistration, for: indexPath, item: configuration)
            }
        }
        return dataSource
    }
}

extension HistoryView: HistoryViewDelegate {
    
    func updateCollection() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HistoryCollectionItem>()

        let newRockPaperItems = GameLogic.historyOfRockPaper.map { feed in
            HistoryCollectionItem(content: .rockPaper(configuration: .init(
                id: feed.id,
                gameStatus: feed.gameStatus,
                computerChose: feed.computerChose,
                userChose: feed.userChose)))
        }
        let newCubeGameItems = GameLogic.historyOfCubeGame.map { feed in
            HistoryCollectionItem(content: .cubeGame(configuration: .init(
                id: feed.id,
                randomCube: feed.randomCube)))
        }
        let throwInfoItems = [GameLogic.throwInfo].map { feed in
            HistoryCollectionItem.init(content: .throwInfo(configuration: .init(
                id: feed.id,
                data: feed.data)))
        }
        let bestSetItem = [GameLogic.bestSet].map { feed in
            HistoryCollectionItem.init(content: .bestSet(configuration: .init(
                id: feed.id,
                bestSet: feed.bestSet)))
        }
            
        snapshot.appendSections([.generalInfo, .rockPaper, .cubeGame])
        snapshot.appendItems(newRockPaperItems, toSection: .rockPaper)
        snapshot.appendItems(newCubeGameItems, toSection: .cubeGame)
        snapshot.appendItems(bestSetItem, toSection: .generalInfo)
        snapshot.appendItems(throwInfoItems, toSection: .generalInfo)

        dataSource.applySnapshotUsingReloadData(snapshot, completion: nil)
    }
}
protocol HistoryViewDelegate: AnyObject {
    func updateCollection()
}
