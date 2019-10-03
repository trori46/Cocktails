//
//  CocktailsViewController.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit
import RxSwift
import CoreData

final class CocktailsViewController: UITableViewController {
    
    var category: Category!
    var viewModels: [Api.Drink] = []
    
    var controller: NSFetchedResultsController<Cocktail>? {
        willSet {
            newValue?.delegate = self
        }
    }
    var output: CocktailsViewOutput!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.observe(with: category)

        tableView.tableFooterView = UIView(frame: .zero)
        output.updateData(with: category)
    }
    
    
    func image(from string: String?) -> UIImage? {
        guard string != nil else { return nil }
        guard let url = URL(string: string!) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
    
    func presentCocktail(with: String) {
        
    }
}

extension CocktailsViewController: CocktailsViewInput {
    
    func didUpdate(_ controller: CocktailsFetchController) {
        self.controller = controller
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        tableView.reloadData()
    }
}

extension CocktailsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = controller?.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        guard let viewModel = controller?.object(at: indexPath) else {
            fatalError("Failed to fetch entities")
        }
        
    
        cell.textLabel?.text = viewModel.name
        
        cell.imageView?.set(from: viewModel.image ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = controller?.object(at: indexPath) else {
            fatalError("Failed to fetch entities")
        }
        presentCocktail(with: viewModel.id!)
    }
}

extension CocktailsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            tableView?.insertRows(at: [newIndexPath!], with: .none)
        case .delete:
            tableView?.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView?.reloadRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView?.deleteRows(at: [indexPath!], with: .fade)
            tableView?.insertRows(at: [newIndexPath!], with: .none)
        @unknown default:
            break
        }
    }
}
