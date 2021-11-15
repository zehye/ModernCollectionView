//
//  CompanyCollectionViewCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/11.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    
//    var item: Company?
//
//    @IBOutlet weak var addressLbl: UILabel!
//    @IBOutlet weak var addressEtcLbl: UILabel!
//    @IBOutlet weak var imgView: UIImageView!
//
//    func setUI(with company: Company) {
//        print(company)
//        self.addressLbl.text = company.addrRoad
//        self.addressEtcLbl.text = company.addrEtc
//        self.imgView.image = UIImage(named: company.introPath)
//    }
    
    weak var addressLbl: UILabel?
//    weak var addressEtcLbl: UILabel?
//    weak var imgView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init")
    }
    
    func setView() {
        self.contentView.backgroundColor = .blue
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
        let addressLbl = UILabel()
        addressLbl.textAlignment = .center
        addressLbl.frame = self.contentView.frame
        self.contentView.addSubview(addressLbl)
        self.addressLbl = addressLbl
    }
    
    func configure(_ data: Company) {
        self.addressLbl?.text = data.addrRoad
    }

}
