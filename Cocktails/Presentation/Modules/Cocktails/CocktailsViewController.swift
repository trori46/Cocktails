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

final class CocktailsViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var category: Category!
    
    private var blockOperations: [BlockOperation] = []
    
    var controller: NSFetchedResultsController<Cocktail>? {
        willSet {
            newValue?.delegate = self
        }
    }
    var output: CocktailsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView.collectionViewLayout as! MosaicViewLayout
        layout.cellPadding = 5
        layout.numberOfColumns = 2
        layout.delegate = self
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(updateData), for: .valueChanged)
        collectionView.refreshControl?.beginRefreshing()
        updateData()
    }
    
    @objc func updateData() {
        output.observe(with: category)
        output.updateData(with: category)
    }
    
    func presentCocktail(with id: String) {
        let controller = assembly.ui.cocktail(with: id)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CocktailsViewController: CocktailsViewInput {
    
    func didUpdate(_ controller: CocktailsFetchController) {
        self.controller = controller
        do {
            try controller.performFetch()
            
            if controller.fetchedObjects?.count == 0 {
                configureEmptyState()
            }
        } catch {
            configure(with: error)
        }
        collectionView.reloadData()
    }
}

extension CocktailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = controller?.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.refreshControl?.endRefreshing()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CocktailsCell
        guard let viewModel = controller?.object(at: indexPath) else {
            configure(with: "Failed to fetch entities")
            return cell
        }
        print("fsdfsf", cell.frame)
        cell.configure(with: viewModel)
        //collectionView.collectionViewLayout.invalidateLayout()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = controller?.object(at: indexPath) else {
            configure(with: "Failed to fetch entities")
            return
        }
        presentCocktail(with: viewModel.id!)
    }
    
}

extension CocktailsViewController: MosaicLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let random = Int.random(in: 1 ..< 4)
        return CGFloat(random * 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
      return 60
    }
}

extension CocktailsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            self.blockOperations.forEach { $0.start() }
        }, completion: { _ in
            self.blockOperations.removeAll(keepingCapacity: false)
        })
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        var block: BlockOperation = BlockOperation()
        
        switch (type) {
        case .insert:
            block = BlockOperation { self.collectionView?.insertItems(at: [newIndexPath!]) }
        case .delete:
            block = BlockOperation { self.collectionView?.deleteItems(at: [indexPath!]) }
        case .update:
            block = BlockOperation { self.collectionView?.reloadItems(at: [indexPath!]) }
        case .move:
            block = BlockOperation { self.collectionView?.deleteItems(at: [indexPath!])
                self.collectionView?.insertItems(at: [newIndexPath!]) }
        @unknown default:
            break
        }
        blockOperations.append(block)
    }
}
