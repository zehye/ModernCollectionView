//
//  SearchCollectionViewCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/16.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    private let searchBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("박지혜님, 궁금한 증상을 질문해보세요!", for: .normal)
        return btn
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
        
        self.contentView.addSubview(self.searchBtn)
        
        self.searchBtn.snp.makeConstraints {(make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
