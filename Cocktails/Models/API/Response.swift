//
//  Response.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation

enum API {
    
    struct Response<T: Decodable> {
        let data: T
    }
}

extension API.Response: Decodable {
    
    enum CodingKeys: String, CodingKey { case data }
    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(T.self, forKey: .data)
    }
}
