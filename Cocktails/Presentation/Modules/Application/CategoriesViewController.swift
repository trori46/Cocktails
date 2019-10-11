//
//  CategoriesViewController.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit

final class CategoriesViewController: UITableViewController {
    
    var viewModels = Category.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init(frame: .zero)
    }
    
    func presentCocktails(with category: Category) {
        let controller = assembly.ui.cocktails(with: category)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CategoriesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.tableCell, for: indexPath) as UITableViewCell
        cell.textLabel?.text = viewModels[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentCocktails(with: viewModels[indexPath.row])
    }
}
