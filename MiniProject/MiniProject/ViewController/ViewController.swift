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
        case consult1, company, consult2, expert
        
        var description: String {
            switch self {
            case .consult1: return "Consult"
            case .company: return "Company"
            case .consult2: return "Consult"
            case .expert: return "Expert"
            }
        }
    }
    
    struct Item: Hashable {
        let expert: Expert?
        let consult: Consult?
        let company: Company?
        
        init(consult: Consult? = nil, company: Company? = nil, expert: Expert? = nil) {
            self.expert = expert
            self.consult = consult
            self.company = company
        }
        
        private let identifier = UUID()
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var companyList = Array<Company>()
    var consultList = Array<Consult>()
    var expertList = Array<Expert>()
    
    var companySnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        super.viewDidLoad()
        
        setData()
        setNavigation()
        createDataSource()
        self.collectionView.collectionViewLayout = self.createLayout()
        createCell()
        applySnapshot()
    }
    
    func setData() {
        print("setData")
        if let path = Bundle.main.path(forResource: "Home", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) { print("path : \(path)")
            do {
                let jsonResult = try JSON(data: data)
                
                let companyResult = jsonResult["companyInfoList"]
                self.companyList = companyResult.arrayValue.compactMap({Company($0)})
                
                let consultResult = jsonResult["consultList"]
                self.consultList = consultResult.arrayValue.compactMap({Consult($0)})
                
                let expertResult = jsonResult["expertList"]
                self.expertList = expertResult.arrayValue.compactMap({Expert($0)})
                
            }catch {
                print("error : \(error)")
            }
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        print("createLayout")
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            if sectionKind == .consult1 || sectionKind == .consult2 {
                print("layout consult")
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupHeight = NSCollectionLayoutDimension.absolute(200)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                section = NSCollectionLayoutSection(group: group)
                
            } else if sectionKind == .company {
                print("layout company")
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else if sectionKind == .expert {
                print("layout expert")
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            }
            else {
                fatalError("Unknown section!")
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func createCell() {
        print("createCell")
        self.collectionView.register(CompanyCollectionViewCell.self, forCellWithReuseIdentifier: "CompanyCell")
        self.collectionView.register(ConsultCollectionViewCell.self, forCellWithReuseIdentifier: "ConsultCell")
        self.collectionView.register(ExpertCollectionViewCell.self, forCellWithReuseIdentifier: "ExpertCell")
    }
    
    func createDataSource() {
        print("createDataSource")
            self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.collectionView) {(collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError() }
            switch section {
            case .company:
                print("datasource company")
                if indexPath.row == self.companyList.count - 1 {
                    self.appendCompany()
                }
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyCell", for: indexPath) as? CompanyCollectionViewCell else { preconditionFailure() }
                cell.configure(item.company!)
                return cell
            case .consult1, .consult2:
                print("datasource consult")
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConsultCell", for: indexPath) as? ConsultCollectionViewCell else { preconditionFailure() }
                cell.configure(item.consult!)
                return cell
            case .expert:
                print("datasource expert")
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpertCell", for: indexPath) as? ExpertCollectionViewCell else { preconditionFailure() }
                cell.configure(item.expert!)
                return cell
            }
        }
    }
    
    func setNavigation() {
        navigationItem.title = "홈"
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .systemGreen
            navigationItem.scrollEdgeAppearance = appearance
            navigationItem.standardAppearance = appearance
            navigationItem.compactAppearance = appearance
            navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
    func applySnapshot() {
        print("appleSnapshot")
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        print(sections)
        print(snapshot)
        
        let consultCount = self.consultList.count
        let consultItems1 = self.consultList[0..<consultCount/2].map { Item(consult: $0) }
        var consultSnapshot1 = NSDiffableDataSourceSectionSnapshot<Item>()
        consultSnapshot1.append(consultItems1)
        
        let companyItems = self.companyList.map { Item(company: $0) }
        companySnapshot.append(companyItems)
        
        let consultItems2 = self.consultList[consultCount/2..<consultCount].map { Item(consult: $0) }
        var consultSnapshot2 = NSDiffableDataSourceSectionSnapshot<Item>()
        consultSnapshot2.append(consultItems2)
        
        let expertItems = self.expertList.map { Item(expert: $0) }
        var expertSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        expertSnapshot.append(expertItems)
        
        dataSource.apply(consultSnapshot1, to: .consult1, animatingDifferences: false)
        dataSource.apply(companySnapshot, to: .company, animatingDifferences: false)
        dataSource.apply(consultSnapshot2, to: .consult2, animatingDifferences: false)
        dataSource.apply(expertSnapshot, to: .expert, animatingDifferences: false)
    }
    
    func appendCompany() {
        print("appendCompany")
        let companyItems = self.companyList.map { Item(company: $0) }
        companySnapshot.append(companyItems)
        dataSource.apply(companySnapshot, to: .company, animatingDifferences: false)
    }
    
}
