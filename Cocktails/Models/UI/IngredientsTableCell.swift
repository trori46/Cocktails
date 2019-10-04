//
//  IngredientsTableCell.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/4/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

final class IngredientsTableCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var measureLabel: UILabel!
    
    func configure(with: (String, String)) {
        ingredientLabel.text = with.0
        measureLabel.text = with.1
    }
}
