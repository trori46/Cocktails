//
//  CachedDrinksService.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import CoreData
import RxSwift

typealias ManagedObjectContext = NSManagedObjectContext

final class CachedDrinksService {
    
    let service: DrinksService
    let context: ManagedObjectContext
    
    init(service: DrinksService, context: ManagedObjectContext) {
        self.service = service
        self.context = context
    }
}

extension CachedDrinksService: DrinksService {
    func drinks(with category: Category) -> Single<[Api.Drink]> {
        service.drinks(with: category)
            .do(onSuccess: { [weak self] in
                try self?.update($0, category: category)
            })
    }
    
    func drink(by id: String) -> Single<Api.Drink.Details> {
        service.drink(by: id).do(onSuccess: { [weak self] in
            try self?.update($0)
        })
    }
}


extension CachedDrinksService {
    
    private func update(_ drinks: [Api.Drink], category: Category) throws {
        //
        //        _ = try drinks.filter { $0.id != nil }
        //            .map { try drink(id: $0.id!) }
        //            .map { deleteDrink($0) }
        //
        drinks.forEach {
            try? update($0, category: category)
        }
    }
    
    private func update(_ drinks: [Api.Drink.Details]) throws {
        
        //        _ = try drinks.filter { $0.id != nil }
        //            .map { try drink(id: $0.id!) }
        //            .map { deleteDrink($0) }
        
        drinks.forEach {
            try? update($0)
        }
    }
    
    private func update(_ model: Api.Drink, category: Category) throws {
        if let id = model.id {
            let cocktail = try drink(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: Cocktail.entity().name!, into: context) as! Cocktail
            cocktail.update(with: model, category: category)
            
            try? context.save()
        }
    }
    
    private func update(_ model: Api.Drink.Details) throws {
        if let id = model.id {
            let cocktail = try drink(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: Cocktail.entity().name!, into: context) as! Cocktail
            cocktail.update(with: model)
            
            try? context.save()
        }
    }
    
    func drink(id: String) throws -> Cocktail? {
        let request = NSFetchRequest<Cocktail>(entityName: Cocktail.entity().name!)
        request.predicate = NSPredicate(format: "id = %@", id)
        return try? context.fetch(request).first
        
    }
    
    func deleteDrink(_ drink: Cocktail?) {
        guard let drink = drink else { return }
        context.delete(drink)
        try? context.save()
    }
}
