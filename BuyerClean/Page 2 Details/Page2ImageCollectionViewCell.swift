//
//  ImageCollectionViewCell.swift
//  BuyerGuide
//
//  Created by Peanuz on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class Page2ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mImage.backgroundColor = .clear
    }
    
}
