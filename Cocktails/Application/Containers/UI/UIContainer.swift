//
//  UIContainer.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit
import Dip

protocol UIContainer {
    func root() -> UIViewController
    func categories() -> UIViewController
    func cocktails(with: Category) -> UIViewController
}

extension DependencyContainer: UIContainer {
    
    func root() -> UIViewController {
        return try! resolve() as RootViewController
    }
    
    func categories() -> UIViewController {
        return try! resolve() as CategoriesViewController
    }
    
    func cocktails(with category: Category) -> UIViewController {
        return try! resolve(arguments: category) as CocktailsViewController
    }
}

extension DependencyContainer {
    
    static func ui() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register { () -> RootViewController in
            let controller = UIStoryboard.main.instantiateViewController() as RootViewController
            return controller
        }
        
        container.register { () -> CategoriesViewController in
            let controller = UIStoryboard.main.instantiateViewController() as CategoriesViewController
            return controller
        }
        
        container.register { (category: Category) -> CocktailsViewController in
            let controller = UIStoryboard.main.instantiateViewController() as CocktailsViewController
            controller.category = category
            controller.service = try container.resolve()
            
            return controller
        }
        
        return container
    }
}

extension UIStoryboard {
    
    static let main = UIStoryboard(name: "Main", bundle: nil)
}

extension UIStoryboard {
    
    func instantiateViewController<ViewController: UIViewController>(withIdentifier identifier: String = .init(describing: ViewController.self)) -> ViewController {
        guard let controller = instantiateViewController(withIdentifier: identifier) as? ViewController else {
            fatalError("Could not find \(ViewController.self) in \(self)")
        }
        
        return controller
    }
}
