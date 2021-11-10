//
//  EmojiViewController.swift
//  ModernCollectionView
//
//  Created by zehye on 2021/11/08.
//

import UIKit

//class EmojiViewController: UIViewController {
//    
//    enum Section {
//        case main
//    }
//    
//    class OutlineItem: Hashable {
//        let title: String
//        let subitems: [OutlineItem]
//        let outlineViewController: UIViewController.Type?
//        
//        init(title: String, viewController: UIViewController.Type? = nil, subitems: [OutlineItem] = []) {
//            self.title = title
//            self.subitems = subitems
//            self.outlineViewController = viewController
//        }
//        
//        private let identifier = UUID()
//        
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(identifier)
//        }
//        
//        static func == (lhs: OutlineItem, rhs: OutlineItem) -> Bool {
//            return lhs.identifier == rhs.identifier
//        }
//    }
//    var dataSource: UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
//    var outlineCollectionView: UICollectionView! = nil
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Modern Collection Views"
//        configureCollectionView()
//        configureDataSource()
//    }
//    
//    private lazy var mebuItems: [OutlineItem] = {
//        return [
//            OutlineItem(title: "OutLines", subitems: [
//                OutlineItem(title: "Emoji Explorer", viewController: EmojiViewController.self)])
//        ]
//    }()
//}
//
//extension ViewController {
//    func configureCollectionView() {
//        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
//        view.addSubview(collectionView)
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        collectionView.backgroundColor = .systemGroupedBackground
//        self.outlineCollectionView = collectionView
//        collectionView.delegate = self
//    }
//    
//    func configureDataSource() {
//        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { (cell, indexPath, menuItem) in
//            // cell의 기본 속성 사용하기 위한 조건 < defaultContentConfiguration
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = menuItem.title
//            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
//            cell.contentConfiguration = contentConfiguration
//            
//            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
//            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
//            // 셀의 배경색 투명하게
//            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
//        }
//        
//        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { cell, indexPath, menuItem in
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = menuItem.title
//            cell.contentConfiguration = contentConfiguration
//            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
//        }
//        
//        dataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>(collectionView: outlineCollectionView) {
//            (collectionView: UICollectionView, indexPath: IndexPath, item: OutlineItem) -> UICollectionViewCell? in
//            // Return the cell.
//            if item.subitems.isEmpty {
//                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
//            } else {
//                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
//            }
//        }
//        
//        let snapshot = initialSnapshot()
//        self.dataSource.apply(snapshot, to: .main, animatingDifferences: false)
//    }
//    
//    func generateLayout() -> UICollectionViewLayout {
//        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
//        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
//        return layout
//    }
//    
//    func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem> {
//        var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()
//        
//        func addItems(_ menuItems: [OutlineItem], to parent: OutlineItem?) {
//            snapshot.append(menuItems, to: parent)
//            for menuItem in menuItems where !menuItem.subitems.isEmpty {
//                addItems(menuItem.subitems, to: menuItem)
//            }
//        }
//        
//        addItems(mebuItems, to: nil)
//        return snapshot
//    }
//}
//
//extension EmojiViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
//        
//        collectionView.deselectItem(at: indexPath, animated: true)
//        
//        if let vc = menuItem.outlineViewController {
//            navigationController?.pushViewController(vc.init(), animated: true)
//        }
//    }
//}
//
