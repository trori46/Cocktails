//
//  CocktailsViewController.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import UIKit
import RxSwift

final class CocktailsViewController: UITableViewController {
    
    var category: Category!
    var service: DrinksService!
    var viewModels: [Api.Drink] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = service.drinks(with: category)
            .do(onSuccess: { [weak self] in
                self?.configure(with: $0)
            })
            .subscribe()
    }
    
    func configure(with: [Api.Drink]) {
        viewModels = with
        tableView.reloadData()
    }
    
    func image(from string: String?) -> UIImage? {
        guard string != nil else { return nil }
        guard let url = URL(string: string!) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}

extension CocktailsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        let viewModel = viewModels[indexPath.row]
        cell.textLabel?.text = viewModel.name
        
        cell.imageView?.image = image(from: viewModel.thumb)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //presentCocktails(with: viewModels[indexPath.row])
    }
}
