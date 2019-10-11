//
//  DrinksServiceImpl.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

import RxSwift
import Alamofire


final class DrinksServiceImpl {
    
    let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
}

extension DrinksServiceImpl: DrinksService {

    func drink(by id: String) -> Single<Api.Drink.Details> {
        let parameters = ["i": id]
        let endpoint = Endpoint(path: "lookup.php", method: .get,
                                parameters: parameters)
        return client.data(endpoint).map { try JSONDecoder().decode(Api.DetailsList.self, from: $0) }.map { $0.details.first! }
    }
    
    func drinks(with category: Category) -> Single<[Api.Drink]> {
        let parameters = ["c": category.rawValue]
        let endpoint = Endpoint(path: "filter.php", method: .get,
                                parameters: parameters)
        return client.data(endpoint).map { try JSONDecoder().decode(Api.DrinksList.self, from: $0) }.map { $0.drinks }
    }
}
