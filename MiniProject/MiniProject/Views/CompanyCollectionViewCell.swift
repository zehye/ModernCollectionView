//
//  CompanyCollectionViewCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/11.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    

    private let profielImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = .clear
        return imgView
    }()
    
    private let companyLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let addressLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init")
    }
    
    func setView() {
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(profielImgView)
        self.contentView.addSubview(companyLbl)
        self.contentView.addSubview(addressLbl)
        
        self.profielImgView.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(12)
            make.leading.equalToSuperview()
            make.height.equalTo(140)
            make.top.equalToSuperview()
        }
        
        self.companyLbl.snp.makeConstraints{(make) in
            make.top.equalTo(self.profielImgView.snp.bottom).inset(-8)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        self.addressLbl.snp.makeConstraints {(make) in
            make.top.equalTo(self.companyLbl.snp.bottom).inset(-8)
            make.leading.trailing.equalTo(self.companyLbl)
            make.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    func configure(_ data: Company) {
        self.profielImgView.image = data.introPath
        self.companyLbl.text = data.companyName
        self.addressLbl.text = data.addrRoad
    }

}
