//
//  APIClient.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import RxSwift
import Alamofire

typealias Parameters = Alamofire.Parameters
typealias HTTPMethod = Alamofire.HTTPMethod
typealias HTTPHeaders = Alamofire.HTTPHeaders
typealias ParameterEncoding = Alamofire.ParameterEncoding

protocol APIClient {
    
    func data(_ endpoint: Endpoint) -> Single<Data>
}
