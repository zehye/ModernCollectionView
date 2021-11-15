//
//  ViewController.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {
        case company
        
        var description: String {
            switch self {
//            case .consult: return "Consult"
            case .company: return "Company"
                
            }
        }
    }
    
    struct Item: Hashable {
//        let consult: Consult?
        let company: Company?
        
        init(company: Company? = nil) {
//            self.consult = consult
            self.company = company
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var companyList = Array<Company>()
//    var consultList = Array<Consult>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setNavigation()
//        setCollectionView()
//        configureDataSource()
        createCell()
        applySnapshot()
    }
    
    func setData() {
        if let path = Bundle.main.path(forResource: "Home", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) { print("path : \(path)")
            do {
                let jsonResult = try JSON(data: data)
                let companyResult = jsonResult["companyInfoList"]
                self.companyList = companyResult.arrayValue.compactMap({Company($0)})
                print(self.companyList)
                
//                let consultResult = jsonResult["consultList"]
//                let re = consultResult.arrayValue.compactMap({Consult($0)})
//                self.consultList = re
//                print(self.consultList)
//                print(jsonResult)
            }catch {
                print("error : \(error)")
            }
        }
    }
    
    func setCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.delegate = self
//        view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
//
//            if sectionKind == .consult {
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.28), heightDimension: .fractionalWidth(0.2))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
//                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//            } else
            if sectionKind == .company {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.28), heightDimension: .fractionalWidth(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else {
                fatalError("Unknown section!")
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
//    func createCompanyCell() -> UICollectionView.CellRegistration<CompanyCollectionViewCell, Item> {
//        return UICollectionView.CellRegistration<CompanyCollectionViewCell, Item> {(cell, indexPath, item) in
////            cell.item = item.company
//            cell.setUI(with: item.company!)
//        }
//    }
//
//    func configureDataSource() {
//        let companyCellRegistration = createCompanyCell()
//        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {(collectionView: UICollectionView, indexPath: IndexPath, identifier: Item) -> UICollectionViewCell? in
//            let cell = collectionView.dequeueConfiguredReusableCell(using: companyCellRegistration, for: indexPath, item: identifier)
//            cell.setUI(with: identifier.company!)
//            return cell
//        }
//    }
    
    func createCell() {
//        let cellResistration = UICollectionView.CellRegistration<CompanyCollectionViewCell, Item> {(cell, indexPath, item) in
//            cell.setUI(with: item.company!)
//        }
//        
//        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.collectionView) {(collectionView, indexPath, company) -> UICollectionViewCell? in
//            return collectionView.dequeueConfiguredReusableCell(using: cellResistration, for: indexPath, item: company)
//        }
        self.collectionView.register(CompanyCollectionViewCell.self, forCellWithReuseIdentifier: "CompanyCell")
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.collectionView) {(collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyCell", for: indexPath) as? CompanyCollectionViewCell else { preconditionFailure() }
//            cell.setUI(with: item.company!)
            cell.configure(item.company!)
            return cell 
        }
    }
    
    func setNavigation() {
        navigationItem.title = "홈"
    }
    
    func applySnapshot() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        print(sections)
        print(snapshot)
        
        let companyItems = self.companyList.map { Item(company: $0) }
        var companySnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        companySnapshot.append(companyItems)
        
        dataSource.apply(companySnapshot, to: .company, animatingDifferences: false)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 180)
    }
}

