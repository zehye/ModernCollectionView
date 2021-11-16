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
    
    private let anwserView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .brown
        textView.text = "상담글이 들어갈 자리입니다"
        return textView
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

    }
    
    func configure(_ data: Consult) {
        self.titleLbl.text = data.title
        self.viewCnt.text = "조회수 \(data.readCnt ?? 0)"
        if let date = data.regDate?.toString(format: "yyyy-MM-dd") {
            self.dateLbl.text = date
        }
        
    }
}
