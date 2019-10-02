//
//  Endpoint.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Alamofire

struct Endpoint {
    
    let path: String
    let method: HTTPMethod
    let parameters: Parameters?
    let encoding: ParameterEncoding
    
    init(path: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
    }
}
