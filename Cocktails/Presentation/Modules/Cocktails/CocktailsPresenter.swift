//
//  CocktailsPresenter.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

typealias  CocktailsFetchController = NSFetchedResultsController<Cocktail>

final class CocktailsPresenter {
    
    var service: DrinksService!
    weak var output: CocktailsViewInput?
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, service: DrinksService) {
        self.context = context
        self.service = service
    }
}

extension CocktailsPresenter: CocktailsViewOutput {
    
    
    func updateData(with category: Category) {
        _ = service.drinks(with: category)
            .subscribe()
    }
    
    func observe(with category: Category) {
        let request = NSFetchRequest<Cocktail>(entityName: Cocktail.entity().name!)
        request.predicate = NSPredicate(format: "category = %@", category.rawValue)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        output?.didUpdate(controller)
    }
}

