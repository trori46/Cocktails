//
//  UIViewController.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(сhild controller: UIViewController, to view: UIView) {
        addChild(controller)
        
        view.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        controller.didMove(toParent: self)
    }
    
    func removeAsChild() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
