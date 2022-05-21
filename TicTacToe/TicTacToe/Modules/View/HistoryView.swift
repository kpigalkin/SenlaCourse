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

final class HistoryView: UIView, UICollectionViewDelegate {
    
    private lazy var dataSource = makeDataSource()

    private let rockPaperRegistration = UICollectionView.CellRegistration<UICollectionViewCell, RockPaperContentConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = nil
        cell.contentConfiguration = itemIdentifier
    }
    
    private let cubeRegistration = UICollectionView.CellRegistration<UICollectionViewCell, CubeGameConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = nil
        cell.contentConfiguration = itemIdentifier
    }
    
    private let throwInfoRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ThrowInfoConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = nil
        cell.contentConfiguration = itemIdentifier
    }
    
    private let bestSetRegistration = UICollectionView.CellRegistration<UICollectionViewCell, BestSetConfiguration> { cell, indexPath, itemIdentifier in
        cell.contentConfiguration = nil
        cell.contentConfiguration = itemIdentifier
    }
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: CollectionViewLayoutFactory.historyFeedLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .systemYellow
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {

        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        addSubviews()
        makeConstraints()
        createSections()
        self.collectionView.delegate = self
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
    
    func createSections() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HistoryCollectionItem>()
        snapshot.appendSections([.generalInfo, .rockPaper, .cubeGame])
        
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
    
    func updateGeneralInfo() {
        
        let throwInfo = HistoryCollectionItem(content: .throwInfo(configuration: .init(
            id: GameLogic.throwInfo.id,
            data: GameLogic.throwInfo.data)))
        let bestSet = HistoryCollectionItem(content: .bestSet(configuration: .init(
            id: GameLogic.bestSet.id,
            bestSet: GameLogic.bestSet.bestSet)))

        var snapshot = dataSource.snapshot(for: .generalInfo)
        
        snapshot.deleteAll()
        snapshot.append([throwInfo, bestSet])
        
        dataSource.apply(snapshot, to: .generalInfo)
    }
}

extension HistoryView: HistoryViewDelegate {
    
    func appendRockPaperItem(_ item: HistoryOfRockPaper) {
        var snapshot = dataSource.snapshot()
        let newItem = HistoryCollectionItem(content: .rockPaper(configuration: .init(
            id: item.id,
            gameStatus: item.gameStatus,
            computerChose: item.computerChose,
            userChose: item.userChose)))
        
        snapshot.appendItems([newItem], toSection: .rockPaper)
        dataSource.apply(snapshot)

        updateGeneralInfo()
    }
    
    func appendCubeGameItem(_ item: HistoryOfCubeGame) {
        var snapshot = dataSource.snapshot()
        let newItem = HistoryCollectionItem(content: .cubeGame(configuration: .init(
            id: item.id,
            randomCube: item.randomCube)))
        
        snapshot.appendItems([newItem], toSection: .cubeGame)
        dataSource.apply(snapshot)

        updateGeneralInfo()
    }
}
    
protocol HistoryViewDelegate: AnyObject {
    func appendRockPaperItem(_ item: HistoryOfRockPaper)
    func appendCubeGameItem(_ item: HistoryOfCubeGame)
}
