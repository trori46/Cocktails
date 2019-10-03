//
//  Drink.swift
//  Cocktails
//
//  Created by Viktoria Rohozhyna on 10/2/19.
//  Copyright © 2019 Viktoria Rohozhyna. All rights reserved.
//

//typealias Cocktails = [Api.Cocktail]

struct Api {
    
    struct DrinksList: Codable {
        
        var drinks: [Drink]
        
        private enum CodingKeys: String, CodingKey {
            case drinks = "drinks"
        }
    }
    
    struct DetailsList: Codable {
        var details: [Drink.Details]
        
        private enum CodingKeys: String, CodingKey {
            case details = "drinks"
        }
    }
    
    
    struct Drink: Codable {
        var id: String?
        var name: String?
        var thumb: String?
        
        private enum CodingKeys: String, CodingKey {
            case id = "idDrink"
            case name = "strDrink"
            case thumb = "strDrinkThumb"
        }
        
        struct Details: Codable {
            
            var id: String?
            var name: String?
            var tags: String?
            var category: String?
            var recipe: String?
            var thumb: String?
            var glass: String?
            var alcoholic: String?
            var ingredients: [String]
            var measures: [String]
           
            
            private enum CodingKeys: String, CodingKey {
                case id = "idDrink"
                case name = "strDrink"
                case category = "strCategory"
                case alcoholic = "strAlcoholic"
                case tags = "strTags"
                case glass = "strGlass"
                case recipe = "strInstructions"
                case thumb = "strDrinkThumb"
            }
            
            static let ingredientsRange = 1...15
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                let indexContainer = try decoder.container(keyedBy: AnyCodingKey.self)
                
                id = try? container.decode(String.self, forKey: .id)
                name = try? container.decode(String.self, forKey: .name)
                category = try? container.decode(String.self, forKey: .category)
                alcoholic = try? container.decode(String.self, forKey: .alcoholic)
                tags = try? container.decode(String.self, forKey: .tags)
                glass = try? container.decode(String.self, forKey: .glass)
                recipe = try? container.decode(String.self, forKey: .recipe)
                thumb = try? container.decode(String.self, forKey: .thumb)

                ingredients = Drink.Details.ingredientsRange.compactMap {
                    try? indexContainer.decode(String.self, forKey: .init(stringLiteral: "ingredient\($0)"))
                }
                measures = Drink.Details.ingredientsRange.compactMap {
                    try? indexContainer.decode(String.self, forKey: .init(stringLiteral: "measure\($0)"))
                }
            }
        }
    }
}
