//
//  Endpoints.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 03/09/25.
//

enum Endpoint {
    case getTrendingRecipes
    case getRecentRecipes
    case complexSearch(sort: String?, number: Int, offset: Int, minLikes: Int)
    case search(query: String)
    
    var path: String {
        switch self {
        case .getTrendingRecipes:
            ""
        case .getRecentRecipes:
            ""
        case .complexSearch(sort: let sort, number: let number, offset: let offset, minLikes: let minLikes):
            ""
        case .search(query: let query):
            ""
        }
    }
    
}
