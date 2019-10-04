//
//  ImageTableCell.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/4/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

final class ImageTableCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    
    func configure(with: String) {
        mainImageView.set(from: with)
    }
}
