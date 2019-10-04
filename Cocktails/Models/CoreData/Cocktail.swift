//
//  Cocktail.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import CoreData

final class Cocktail: NSManagedObject {
    
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var category: String?
    @NSManaged var tags: String?
    @NSManaged var alcoholic: String?
    @NSManaged var glass: String?
    @NSManaged var image: String?
    @NSManaged var recipe: String?

    @NSManaged var ingredients: [String]?
    @NSManaged var measures: [String]?
    
    var instructions: [String: String]?
    
    func update(with model: Api.Drink, category: Category) {
        self.id = model.id
        self.name = model.name
        self.category = category.rawValue
        self.image = model.thumb
    }
    
    func update(with model: Api.Drink.Details) {
        self.id = model.id
        self.name = model.name
        self.category = model.category
        self.tags = model.tags
        self.alcoholic = model.alcoholic
        self.glass = model.glass
        self.recipe = model.recipe
        self.measures = model.measures
        self.ingredients = model.ingredients
        
        instructions = Dictionary(keys: ingredients!, values: measures!)
        self.image = model.thumb
    }
}


