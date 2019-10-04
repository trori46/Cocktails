//
//  CocktailProtocols.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation

protocol CocktailViewOutput {
    
    func updateData(with: String)
    func observe(with: String)
}

protocol CocktailViewInput: class {
    
    func didUpdate(_ controller: CocktailsFetchController)
}

