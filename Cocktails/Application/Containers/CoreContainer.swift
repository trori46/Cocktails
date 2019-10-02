//
//  CoreContainer.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Dip

protocol CoreContainer {
    
    func apiClient() -> APIClient
}

extension DependencyContainer: CoreContainer {
    
    func apiClient() -> APIClient {
        return try! resolve()
    }
}


extension DependencyContainer {
    
    static func core() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register(.singleton) { () -> APIClient in
            
            let client = APIClientImpl(baseURL: URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")!)
            
            return client
        }
        
        return container
    }
}
