//
//  TextTableCell.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/4/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

final class TextTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}
