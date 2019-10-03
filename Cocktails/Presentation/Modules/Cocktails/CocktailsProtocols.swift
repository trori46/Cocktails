//
//  CocktailsProtocols.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation

protocol CocktailsViewOutput {
    
    func updateData(with: Category)
    func observe(with: Category)
}

protocol CocktailsViewInput: class {
    
    func didUpdate(_ controller: CocktailsFetchController)
}
