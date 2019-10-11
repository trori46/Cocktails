//
//  AnyCodingKey.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation

struct AnyCodingKey: CodingKey {
    
    let stringValue: String
    let intValue: Int?
    
    init?(stringValue: String) {
        self = .init(stringLiteral: stringValue)
    }
    
    init?(intValue: Int) {
        self = .init(integerLiteral: intValue)
    }
}

extension AnyCodingKey: ExpressibleByStringLiteral {
    
    init(stringLiteral value: String) {
        stringValue = value
        intValue = Int(value)
    }
}

extension AnyCodingKey: ExpressibleByIntegerLiteral {
    
    init(integerLiteral value: Int) {
        stringValue = "\(value)"
        intValue = value
    }
}
