//
//  Assembly.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Dip

let assembly: Assembly = .init(ui: .ui(), services: .services(), core: .core())

struct Assembly {
    let ui: UIContainer
    let core: UIContainer
    let services: UIContainer
    
    fileprivate init(ui: DependencyContainer, services: DependencyContainer, core: DependencyContainer) {
        self.core = core
        self.services = services
        self.ui = ui
        
        ui.collaborate(with: services)
        services.collaborate(with: core)
    }
}
