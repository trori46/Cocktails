//
//  BaseViewController.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/4/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func configure(with error: Error) {
        
        let controller = UIAlertController(title: "", message: error.localizedDescription,
                                           preferredStyle: .alert)
        controller.addAction(.init(title: "Okay", style: .cancel))
        present(controller, animated: true)
    }
    
    func configure(with error: String, completion: (() -> Void)? = nil) {
        
        let controller = UIAlertController(title: "", message: error,
                                           preferredStyle: .alert)
        controller.addAction(.init(title: "Okay", style: .cancel))
        present(controller, animated: true, completion: completion)
    }
    
    func configureEmptyState() {
        configure(with: "There is no Internet connection") { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}
