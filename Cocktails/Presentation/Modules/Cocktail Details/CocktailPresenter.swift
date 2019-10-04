//
//  CocktailPresenter.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation
import CoreData

final class CocktailPresenter {
    
    var service: DrinksService!
    weak var output: CocktailViewInput?
    let context: NSManagedObjectContext
    
    init(service: DrinksService, context: NSManagedObjectContext) {
        self.service = service
        self.context = context
    }
}

extension CocktailPresenter: CocktailViewOutput {

    func updateData(with: String) {
        _ = service.drink(by: with)
            .do(onSuccess: {
                print($0)
            })
        .subscribe()
    }
    
    func observe(with: String) {
        let request = NSFetchRequest<Cocktail>(entityName: Cocktail.entity().name!)
        request.predicate = NSPredicate(format: "id = %@", with)
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        output?.didUpdate(controller)
    }
}
