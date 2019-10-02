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
            var ingredient1: String?
            var ingredient2: String?
            var ingredient3: String?
            var ingredient4: String?
            var ingredient5: String?
            var ingredient6: String?
            var ingredient7: String?
            var ingredient8: String?
            var ingredient9: String?
            var ingredient10: String?
            var ingredient11: String?
            var ingredient12: String?
            var ingredient13: String?
            var ingredient14: String?
            var ingredient15: String?
            var measure1: String?
            var measure2: String?
            var measure3: String?
            var measure4: String?
            var measure5: String?
            var measure6: String?
            var measure7: String?
            var measure8: String?
            var measure9: String?
            var measure10: String?
            var measure11: String?
            var measure12: String?
            var measure13: String?
            var measure14: String?
            var measure15: String?
            
            private enum CodingKeys: String, CodingKey {
                case id = "idDrink"
                case name = "strDrink"
                case category = "strCategory"
                case alcoholic = "strAlcoholic"
                case tags = "strTags"
                case glass = "strGlass"
                case recipe = "strInstructions"
                case thumb = "strDrinkThumb"
                case ingredient1 = "strIngredient1"
                case ingredient2 = "strIngredient2"
                case ingredient3 = "strIngredient3"
                case ingredient4 = "strIngredient4"
                case ingredient5 = "strIngredient5"
                case ingredient6 = "strIngredient6"
                case ingredient7 = "strIngredient7"
                case ingredient8 = "strIngredient8"
                case ingredient9 = "strIngredient9"
                case ingredient10 = "strIngredient10"
                case ingredient11 = "strIngredient11"
                case ingredient12 = "strIngredient12"
                case ingredient13 = "strIngredient13"
                case ingredient14 = "strIngredient14"
                case ingredient15 = "strIngredient15"
                case measure1 = "strMeasure1"
                case measure2 = "strMeasure2"
                case measure3 = "strMeasure3"
                case measure4 = "strMeasure4"
                case measure5 = "strMeasure5"
                case measure6 = "strMeasure6"
                case measure7 = "strMeasure7"
                case measure8 = "strMeasure8"
                case measure9 = "strMeasure9"
                case measure10 = "strMeasure10"
                case measure11 = "strMeasure11"
                case measure12 = "strMeasure12"
                case measure13 = "strMeasure13"
                case measure14 = "strMeasure14"
                case measure15 = "strMeasure15"
            }
        }
    }
}

