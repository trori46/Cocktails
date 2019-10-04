//
//  CocktailsService.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import RxSwift

protocol DrinksService {
    
    func drinks(with: Category) -> Single<[Api.Drink]>
    func drink(by: String) -> Single<Api.Drink.Details>
}
