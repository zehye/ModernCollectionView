//
//  ViewController.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit

class ViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Home, Company>!
    var homeJson = Home.jsonwithModel
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setCollectionView()
        applySnapshot()
    }
    
    private func setCollectionView() {
        collectionView.register(UINib(nibName: "CompanyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CompanyCell")
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, company) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyCell", for: indexPath) as! CompanyCollectionViewCell
            cell.setUI(with: company)
            return cell
        }
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 12
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        layout.sectionInsetReference = .fromContentInset
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//
//        collectionView.collectionViewLayout = layout
//        collectionView.delegate = self
        
    }
    
    private func setNavigation() {
        navigationItem.title = "홈"
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Home, Company>()
        homeJson.forEach {(json) in
            let (json, company) = json
            snapshot.appendSections([json])
            snapshot.appendItems(company, toSection: json)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 300, height: 180)
//    }
//}

