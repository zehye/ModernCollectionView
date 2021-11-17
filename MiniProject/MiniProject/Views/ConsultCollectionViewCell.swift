//
//  ConsultCollectionViewCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/12.
//

import UIKit

class ConsultCollectionViewCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        lbl.numberOfLines = 1
        lbl.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        lbl.setContentCompressionResistancePriority(UILayoutPriority(748), for: .vertical)
        return lbl
    }()
    
    private let anwserView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let profileImg: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 40/2
        return imgView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.setContentHuggingPriority(UILayoutPriority(749), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(751), for: .vertical)
        return label
    }()
    
    private let viewCnt: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        return lbl
    }()
    
    private let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        self.containerView.addSubview(self.titleLbl)
        self.containerView.addSubview(self.anwserView)
        self.contentView.addSubview(self.bottomView)
        self.anwserView.addSubview(self.nameLabel)
        self.anwserView.addSubview(self.profileImg)
        self.anwserView.addSubview(self.leftView)
        self.anwserView.addSubview(self.contentLabel)
        self.containerView.addSubview(self.viewCnt)
        self.containerView.addSubview(self.dateLbl)
        
        self.containerView.snp.makeConstraints {(make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        self.titleLbl.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(16)
        }
        
        self.anwserView.snp.makeConstraints {(make) in
            make.top.equalTo(titleLbl.snp.bottom).inset(-4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.leftView.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(12)
            make.width.equalTo(5)
            make.top.bottom.equalToSuperview()
        }
        
        self.profileImg.snp.makeConstraints {(make) in
            make.leading.equalTo(self.leftView.snp.trailing).inset(-16)
            make.size.equalTo(40)
            make.top.equalTo(self.leftView.snp.top)
        }
        
        self.nameLabel.snp.makeConstraints {(make) in
            make.leading.equalTo(self.profileImg.snp.trailing).inset(-8)
            make.centerY.equalTo(self.profileImg.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
        
        self.contentLabel.snp.makeConstraints {(make) in
            make.top.equalTo(self.profileImg.snp.bottom).inset(-10)
            make.leading.equalTo(self.profileImg.snp.leading)
            make.trailing.equalTo(self.nameLabel.snp.trailing)
            make.bottom.equalTo(self.leftView.snp.bottom)
        }
        
        self.viewCnt.snp.makeConstraints {(make) in
            make.leading.equalTo(self.titleLbl.snp.leading)
            make.top.equalTo(self.anwserView.snp.bottom).inset(-4)
            make.bottom.equalToSuperview().inset(12)
        }
        
        self.dateLbl.snp.makeConstraints {(make) in
            make.leading.greaterThanOrEqualTo(self.viewCnt.snp.trailing).inset(-12)
            make.centerY.equalTo(self.viewCnt.snp.centerY)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.bottomView.snp.makeConstraints {(make) in
            make.bottom.equalToSuperview().inset(0)
            make.height.equalTo(5)
            make.leading.trailing.equalToSuperview()
        }

    }
    
    func configure(_ data: Consult) {
        self.titleLbl.text = data.title
        self.viewCnt.text = "조회수 \(data.readCnt ?? 0)"
        if let date = data.regDate?.toString(format: "yyyy-MM-dd") {
            self.dateLbl.text = date
        }
        
        self.profileImg.image = data.profileImg
        self.nameLabel.text = "\(data.name!)/\(data.expertTypeName!)/\(data.companyName!)"
        self.contentLabel.text = data.content
    }
}
