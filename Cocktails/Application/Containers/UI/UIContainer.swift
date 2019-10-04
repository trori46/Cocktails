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
    func cocktail(with: String) -> UIViewController

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
    
    func cocktail(with id: String) -> UIViewController {
        return try! resolve(arguments: id) as CocktailViewController
    }
}

extension DependencyContainer {
    
    static func ui() -> DependencyContainer {
        let container = DependencyContainer()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        container.register { () -> RootViewController in
            let controller = UIStoryboard.main.instantiateViewController() as RootViewController
            return controller
        }
        
        container.register { () -> CategoriesViewController in
            let controller = UIStoryboard.main.instantiateViewController() as CategoriesViewController
            controller.navigationController?.navigationItem.largeTitleDisplayMode = .never
            return controller
        }
        
        container.register { (category: Category) -> CocktailsViewController in
            let controller = UIStoryboard.main.instantiateViewController() as CocktailsViewController
            controller.category = category
            controller.navigationController?.navigationItem.largeTitleDisplayMode = .never

            let presenter = CocktailsPresenter(context: context,
                                               service: try container.resolve())
            controller.output = presenter
            presenter.output = controller
            
            return controller
        }
        
        container.register { (id: String) -> CocktailViewController in
            let controller = UIStoryboard.main.instantiateViewController() as CocktailViewController
            controller.navigationItem.largeTitleDisplayMode = .never

            controller.navigationController?.navigationBar.barTintColor = .white
            controller.id = id
            let presenter = CocktailPresenter(service: try container.resolve(), context: context)
            controller.output = presenter
            presenter.output = controller
            
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
