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
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func createSections() {
        
        print("⭕️ createSections HistoryView\n")
        
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
    // MARK: Update snapshot
    func updateGeneralInfo(viewModel: Clean.Something.ViewModel) {
        print("⭕️ updateGeneralInfo HistoryView\n")

        var snapshot = dataSource.snapshot(for: .generalInfo)
        
        snapshot.deleteAll()
        snapshot.append([viewModel.throwInfo, viewModel.bestSet])
        
        dataSource.apply(snapshot, to: .generalInfo)
    }
}

extension HistoryView: HistoryViewDelegate {
    
    func appendNewItems(viewModel: Clean.Something.ViewModel, section: Section) {
        print("⭕️ viewModel HistoryView\n")
        
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([viewModel.item], toSection: section)
        dataSource.apply(snapshot)
        
        updateGeneralInfo(viewModel: viewModel)
    }
}
    
protocol HistoryViewDelegate: AnyObject {
    func appendNewItems(viewModel: Clean.Something.ViewModel, section: Section)
}
