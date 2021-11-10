//
//  EmojiCollectionViewCell.swift
//  ModernCollectionView
//
//  Created by zehye on 2021/11/09.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    var data: Emoji?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(){
        
    }

}
