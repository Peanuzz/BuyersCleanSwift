//
//  Page1TableViewCell.swift
//  BuyerClean
//
//  Created by Peanuz on 31/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class Page1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(phone: DisplayedPhone) {
        nameLabel.text = phone.name
        descriptionLabel.text = phone.description
        priceLabel.text = "Price: $\(phone.price)"
        ratingLabel.text = "Rating: \(phone.rating)"
        productImageView.kf.setImage(with: URL(string: phone.thumbImageURL))
    }

}
