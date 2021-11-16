//
//  ExpertCollectionViewCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/16.
//

import UIKit
import SnapKit

class ExpertCollectionViewCell: UICollectionViewCell {

    private let containerView: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()

    private let expertTypelbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .center
        return lbl
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let taglbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setView() {
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.nameLbl)
        self.containerView.addSubview(self.expertTypelbl)
        self.containerView.addSubview(self.profileImageView)
        self.containerView.addSubview(self.taglbl)

        self.containerView.snp.makeConstraints{(make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    
        self.profileImageView.snp.makeConstraints {(make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(70)
        }

        self.nameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileImageView.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview()
        }

        self.expertTypelbl.snp.makeConstraints {(make) in
            make.top.equalTo(self.nameLbl.snp.bottom).inset(-4)
            make.leading.trailing.equalTo(self.nameLbl)
        }
        
        self.taglbl.snp.makeConstraints {(make) in
            make.top.equalTo(self.expertTypelbl.snp.bottom).inset(-4)
            make.leading.trailing.equalTo(self.nameLbl)
        }
        
    }
    
    func configure(_ data: Expert) {
        self.profileImageView.image = data.profilePath
        self.nameLbl.text = data.name
        self.expertTypelbl.text = data.expertTypeName
    }
}
