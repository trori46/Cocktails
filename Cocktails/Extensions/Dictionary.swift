//
//  Dictionary.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/4/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation

extension Dictionary where Value == String {
    public init(keys: [Key], values: [Value]) {
        self.init()

        let div = keys.count - values.count
        var newValues = values
        if div > 0 {
            (1...div).forEach {_ in
                newValues.append("")
            }
        }
        
        for (index, key) in keys.enumerated() {
            self[key] = newValues[index]
        }
    }
}
