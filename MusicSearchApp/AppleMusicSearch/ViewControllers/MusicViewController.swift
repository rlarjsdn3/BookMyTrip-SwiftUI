//
//  ViewController.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import UIKit

import Then
import SnapKit
import RxDataSources
import ReactorKit
import RxCocoa
import RxSwift

class MusicViewController: UIViewController, ReactorKit.View {
    // MARK: - Views
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: compositionalLayout).then {
            $0.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "musicCell")
            $0.backgroundColor = UIColor.systemBackground
        }
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] index, _ in
            switch self?.dataSource.sectionModels[index] {
            case .countSection:
                return self?.createGridLayout()
            case .musicSection:
                return self?.createGridLayout()
            case .none:
                return self?.createGridLayout()
            }
        }
        return layout
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Properties
    var disposeBag: DisposeBag = DisposeBag()
    let musicViewReactor: MusicViewReactor = MusicViewReactor()
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<SearchMusicSections>!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setupAttributes()
        
        prepareDatasource()
        
        bind(reactor: musicViewReactor)
    }
    
    // MARK: - Helpers
    func bind(reactor: MusicViewReactor) {
        // Action
        searchController.searchBar.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .map { Reactor.Action.didChangeText($0) }
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.sectionedMusic }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func setupUI() {
        view.addSubview(collectionView)
    }
    
    func setupConstraint() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupAttributes() {
        navigationItem.title = "iTunes"
        navigationItem.searchController = searchController
    }
    
    func prepareDatasource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<SearchMusicSections> { dataSource, collectionView, indexPath, item in
            switch dataSource[indexPath] {
            case let .countItem(count):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
                cell.reactor = MusicCellReactor(state: Music(artistName: "\(count)", albumName: "\(count)", songName: "\(count)", coverImageUrl: "\(count)"))
                return cell
            case let .musicItem(item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
                cell.reactor = MusicCellReactor(state: item)
                return cell
            }
        }
    }
    
    func createGridLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 2
        )
        group.interItemSpacing = .flexible(10.0)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = .zero
        section.contentInsets.top = 10.0
        section.contentInsets.leading = 10.0
        section.contentInsets.trailing = 10.0
        
        return section
    }
}

