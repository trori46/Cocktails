//
//  UIImage.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func set(from string: String) {
        let url = URL(string: string)!
        let placeholderImage = UIImage(named: "placeholder")!
        print(self.frame)
       // let filter = AspectScaledToFillSizeFilter(size: self.frame.size)
        self.af_setImage(withURL: url, placeholderImage: placeholderImage)
            //, filter: filter)
    }
}
