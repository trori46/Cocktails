//
//  ServicesContainer.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Dip

protocol ServicesContainer {
    
    func service<T>(_ type: T.Type) -> T
}

extension DependencyContainer: ServicesContainer {
    
    func service<T>(_ type: T.Type) -> T {
        return try! resolve()
    }
}

extension DependencyContainer {
    
    static func services() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register(.singleton) { () -> DrinksService in
            let service = DrinksServiceImpl(client: try container.resolve())
            return service
        }
        return container
    }
}
