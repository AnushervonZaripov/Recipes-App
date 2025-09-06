//
//  Endpoints.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 03/09/25.
//

enum Endpoint {
    case trendingRecipes(number: Int, offset: Int)
    case popularRecipes(number: Int, offset: Int, cuisine: String?)
    case recentRecipes(number: Int, offset: Int)
    case search(query: String, number: Int, offset: Int)
    case recipeInformation(id: Int, includeNutrition: Bool)
    
    var path: String {
        switch self {
        case .trendingRecipes,
                .popularRecipes,
                .recentRecipes,
                .search:
            return "/recipes/complexSearch"
        case .recipeInformation(let id, _):
            return "/recipes/\(id)/information"
        }
    }
}
