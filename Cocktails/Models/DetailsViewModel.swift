//
//  DetailsViewModel.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/4/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import Foundation

enum ViewModel {
    
    case image(String), title(String), tags(String),  recipe(String), instructions((String, String))
}

extension ViewModel {
    
    static func get(with: Cocktail) -> ViewModels {
        var viewModels = ViewModels()
        with.image.map(ViewModel.image).map { viewModels.append($0) }
        with.name.map(ViewModel.title).map { viewModels.append($0) }
        with.tags.map(ViewModel.tags).map { viewModels.append($0) }
        with.recipe.map(ViewModel.recipe).map { viewModels.append($0) }
        with.instructions.map {
            $0.forEach {
                viewModels.append(ViewModel.instructions($0))
            }
        }
        return viewModels
    }
}
