//
//  UI.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

class CocktailsCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with: Cocktail) {
        imageView.set(from: with.image ?? "")
        titleLabel.text = with.name
    }
}
