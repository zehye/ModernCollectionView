//
//  CompanyCollectionViewCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/11.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressEtcLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func setUI(with company: Company) {
        print(company)
        self.addressLbl.text = company.addrRoad
        self.addressEtcLbl.text = company.addrEtc
        self.imgView.image = UIImage(named: company.introPath)
    }

}
