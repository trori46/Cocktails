//
//  RootViewController.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentCategories()
    }
    
    func presentCategories() {
        let controller = UINavigationController(rootViewController: assembly.ui.categories())
        set(controller, animated: true)
    }
    
    func set(_ viewController: UIViewController, animated: Bool) {
        dismiss(animated: true)
        children.forEach { $0.removeAsChild() }
        add(сhild: viewController, to: view)
    }
}
