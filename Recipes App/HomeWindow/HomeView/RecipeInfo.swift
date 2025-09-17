//
//  RecipeInfo.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 08/09/25.
//

struct RecipeInfo: Codable {
           let extendedIngredients: [DetailsOfIngredient]
       }
       
struct DetailsOfIngredient: Codable {
           let id: Int
           let name: String
           let amount: Double?
           let unit: String?
       }
