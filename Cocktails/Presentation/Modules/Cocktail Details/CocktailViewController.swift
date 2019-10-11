//
//  CocktailViewController.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/3/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit
import CoreData

typealias ViewModels = [ViewModel]

final class CocktailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var output: CocktailViewOutput!
    var id: String!
    
    var controller: NSFetchedResultsController<Cocktail>? {
        willSet {
            newValue?.delegate = self
        }
    }
    
    var viewModels: ViewModels = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init(frame: .zero)
        output.observe(with: id)
        output.updateData(with: id)
    }
    
    func configure() {
        if controller?.fetchedObjects?.count == 0 {
            configureEmptyState()
        }
        
        viewModels = controller?.fetchedObjects?.first.map(ViewModel.get) ?? []
        tableView.reloadData()
    }
}

extension CocktailViewController: CocktailViewInput {
    
    func didUpdate(_ controller: CocktailsFetchController) {
        self.controller = controller
        do {
            try controller.performFetch()
            configure()
        } catch {
            configure(with: error)
        }
    }
}

extension CocktailViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        configure()
    }
}

extension CocktailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel {
        case .image(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.imageTableCell) as! ImageTableCell
            cell.configure(with: value)
            return cell
        case .title(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.titleTableCell) as! TextTableCell
            cell.configure(with: value)
            return cell
        case .tags(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.tagsTableCell) as! TextTableCell
            cell.configure(with: value)
            return cell
        case .recipe(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.recipeTableCell) as! TextTableCell
            cell.configure(with: value)
            return cell
        case .instructions(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.ingredientsTableCell) as! IngredientsTableCell
            cell.configure(with: value)
            return cell
        }
    }
}
