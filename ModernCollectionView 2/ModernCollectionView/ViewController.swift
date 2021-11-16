//
//  ViewController.swift
//  ModernCollectionView
//
//  Created by zehye on 2021/11/08.
//

import UIKit

class ViewController: UIViewController {
    // hash > unique한 key: set or dict key값에 클래스나 구조체를 넣을 때 사용
    // hash table의 key값이 될 수 있도록 도와주는 프로토콜 > hash table에서 hash값을 찾기 위해서는 고유한 key값이 필요
    // caseIterable > 배열과 같이 순회 가능
    // customStringConveertible > 사용자 정의에 따른 텍스트 출력 가능
    enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {  // 섹션에 들어갈 데이터 정의
        case recents, outline, list, custom 
        
        var description: String {
            switch self {
            case .recents: return "Recents"
            case .outline: return "Outline"
            case .list: return "List"
            case .custom: return "Custom"
            }
        }
    }
    
    struct Item: Hashable {  // 섹션 속 아이템에 들어갈 데이터 정의
        let title: String?
        let emoji: Emoji?
        let hasChild: Bool
        
        init(emoji: Emoji? = nil, title: String? = nil, hasChild: Bool = false) {
            self.emoji = emoji
            self.title = title
            self.hasChild = hasChild
        }
        
        private let identifier = UUID()
    }
    
    var starredEmoji = Set<Item>()
    
    var collectionView: UICollectionView!
    
    // Data Source에 객체를 할당
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavItem()
        configureHierarchy()
        configureDataSource()
        applyInitialSnapshots()
        
//        self.collectionView.register(UINib(nibName: "EmojiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "customCell")
    }
}

extension ViewController {
    func configureNavItem() {
        navigationItem.title = "Emoji"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // collectionView
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }
    
    // 섹션별로 다른 레이아웃 가능
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let ssectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            
            if ssectionKind == .recents {
                // display width / content height (내부 컨텐츠 길이에 맞추겠다)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                // width에 대한 상대값
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.28), heightDimension: .fractionalHeight(0.1))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else if ssectionKind == .outline {
                var configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
                configuration.leadingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
                    guard let self = self else { return nil }
                    guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
                    return self.leadingSwipeActionConfigurationForListCellItem(item)
                }
                section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
                
//                section = NSCollectionLayoutSection.list(using: .init(appearance: .), layoutEnvironment: layoutEnvironment)
//                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
            } else if ssectionKind == .list {
                var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
                configuration.leadingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
                    guard let self = self else { return nil }
                    guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
                    return self.leadingSwipeActionConfigurationForListCellItem(item)
                }
                section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            } else if ssectionKind == .custom {
                section = NSCollectionLayoutSection.list(using: .init(appearance: .plain), layoutEnvironment: layoutEnvironment)
                section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 10, bottom: 0, trailing: 10)
            } else {
                fatalError("Unknown section!")
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func accessoriesForListCellItem(_ item: Item) -> [UICellAccessory] {
        let isStarred = self.starredEmoji.contains(item)
        var accessories = [UICellAccessory.disclosureIndicator()]
        if isStarred {
            let star = UIImageView(image: UIImage(systemName: "star.fill"))
            accessories.append(.customView(configuration: .init(customView: star, placement: .trailing())))
        }
        return accessories
    }
    
    // 왼쪽 스와이프
    func leadingSwipeActionConfigurationForListCellItem(_ item: Item) -> UISwipeActionsConfiguration? {
        let isStarred = self.starredEmoji.contains(item)
        let starAction = UIContextualAction(style: .normal, title: nil) {
            [weak self] (_, _, completion) in
            guard let self = self else {
                completion(false)
                return
            }
            
            // 별 있으면 삭제
            if isStarred {
                self.starredEmoji.remove(item)
            } else {
                // 없으먄 추가
                self.starredEmoji.insert(item)
            }
            
            // 스와이프 해서 얻은 결과값(item) accessoriesForListCellItem에 적용
            if let currentIndexPath = self.dataSource.indexPath(for: item) {
                if let cell = self.collectionView.cellForItem(at: currentIndexPath) as? UICollectionViewListCell {
                    UIView.animate(withDuration: 0.2) {
                        cell.accessories = self.accessoriesForListCellItem(item)
                    }
                }
            }
            completion(true)
        }
        // 별 있으면 슬래시 있는 별, 아니면 꽉찬 별
        starAction.image = UIImage(systemName: isStarred ? "star.slash" : "star.fill")
        starAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [starAction])
    }
    
    // recent > grid cell registration
    func createGridCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewCell, Emoji> {
        // 셀 등록 > iOS14부터는 cell registration을 통해 새롭게 cell을 구성할 수 있음
        return UICollectionView.CellRegistration<UICollectionViewCell, Emoji> { (cell, indexPath, emoji) in
            // 테이블 뷰와 같이 셀에 대한 표준화된 레이아웃을 제공
            var content = UIListContentConfiguration.cell()
            content.text = emoji.text
            content.textProperties.font = .boldSystemFont(ofSize: 38)
            content.textProperties.alignment = .center
            content.directionalLayoutMargins = .zero
            cell.contentConfiguration = content
            var background = UIBackgroundConfiguration.listPlainCell()
            background.cornerRadius = 8
            background.strokeColor = .systemGray3
            background.strokeWidth = 1.0 / cell.traitCollection.displayScale
            cell.backgroundConfiguration = background
        }
    }
    
    // outline header cell registration
    func createOutlineHeaderCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, title) in
            var content = cell.defaultContentConfiguration()
            content.text = title
            cell.contentConfiguration = content
            cell.accessories = [.outlineDisclosure(options: .init(style: .header))]
        }
    }
    
    // outline cell registration
    func createOutlineCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Emoji> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Emoji> { (cell, indexPath, emoji) in
            var content = cell.defaultContentConfiguration()
            content.text = emoji.text
            content.secondaryText = emoji.title
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    // list > list cell registration
    func createListCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Item> { [weak self] (cell, indexPath, item) in
            guard let self = self, let emoji = item.emoji else { return }
            var content = UIListContentConfiguration.valueCell()
            content.text = emoji.text
            content.secondaryText = String(describing: emoji.category)
            cell.contentConfiguration = content
            cell.accessories = self.accessoriesForListCellItem(item)
        }
    }
    
    func createPlainCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
//        return self.collectionView.register(UINib(nibName: "EmojiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "customCell")
//        self.collectionView.register(UINib(nibName: "EmojiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "customCell")
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: Ind)
        
        return  UICollectionView.CellRegistration<UICollectionViewListCell, Item> { [weak self] (cell, indexPath, item) in
            var content = self?.collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! EmojiCollectionViewCell
            content.titleLbl.text = item.title
            print(content)
            
        }
    }
    
    func configureDataSource() {
        // create registrations up front, then choose the appropriate one to use in the cell provider
        let gridCellRegistration = createGridCellRegistration()
        let listCellRegistration = createListCellRegistration()
        let outlineHeaderCellRegistration = createOutlineHeaderCellRegistration()
        let outlineCellRegistration = createOutlineCellRegistration()
        let createPlaceRegistration = createPlainCellRegistration()
        
        // data source
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            // recent
            case .recents:
                return collectionView.dequeueConfiguredReusableCell(using: gridCellRegistration, for: indexPath, item: item.emoji)
            // 맨 아래 list
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: item)
            // outline > header, cell
            case .outline:
                if item.hasChild {
                    return collectionView.dequeueConfiguredReusableCell(using: outlineHeaderCellRegistration, for: indexPath, item: item.title!)
                } else {
                    return collectionView.dequeueConfiguredReusableCell(using: outlineCellRegistration, for: indexPath, item: item.emoji)
                }
                
            case .custom:
                return collectionView.dequeueConfiguredReusableCell(using: createPlaceRegistration, for: indexPath, item: item)
                
            }
        }
    }
    
    // 스냅샷 적용
    // NSDiffableDataSourceSnapshot > 데이터 접근, 특정 인덱스에 데이터 삽입 및 삭제 가능 > apply 통해 변경사항 적용 
    func applyInitialSnapshots() {
        let sections = Section.allCases
//        print(sections)
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//        print(snapshot)
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        // recents
        let recentItems = Emoji.Category.recents.emojis.map { Item(emoji: $0) }
//        print(recentItems)
        var recentsSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        recentsSnapshot.append(recentItems)

        // list + outlines
        var allSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        var outlineSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        
        for category in Emoji.Category.allCases where category != .recents {
            // append to the "all items" snapshot
            let allSnapshotItems = category.emojis.map { Item(emoji: $0) }
            allSnapshot.append(allSnapshotItems)
            
            // setup our parent/child relations
            let rootItem = Item(title: String(describing: category), hasChild: true)
            outlineSnapshot.append([rootItem])
            let outlineItems = category.emojis.map { Item(emoji: $0) }
            outlineSnapshot.append(outlineItems, to: rootItem)
        }
        
        let customItems = Emoji.Category.recents.emojis.map { Item(emoji: $0) }
        var cusomSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        cusomSnapshot.append(customItems)
        
        dataSource.apply(recentsSnapshot, to: .recents, animatingDifferences: false)
        dataSource.apply(allSnapshot, to: .list, animatingDifferences: false)
        dataSource.apply(outlineSnapshot, to: .outline, animatingDifferences: false)
        dataSource.apply(cusomSnapshot, to: .list, animatingDifferences: false)
        
        
        // prepopulate starred emojis
//        for _ in 0..<5 {
//            if let item = allSnapshot.items.randomElement() {
//                self.starredEmoji.insert(item)
//            }
//        }
    }
}
