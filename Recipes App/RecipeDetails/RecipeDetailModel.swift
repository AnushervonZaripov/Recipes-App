//
//  RecipeDetailModel.swift
//  Recipes App
//
//  Created by Aziza Azizova on 10/09/25.
//

import Foundation

struct RecipeDetailModel: Decodable {
    let id: Int
    let title: String
    let image: String?
    let summary: String?
    let readyInMinutes: Int?
    let servings: Int?
    let extendedIngredients: [ExtendedIngredient]?
    let analyzedInstructions: [Instruction]?

    struct ExtendedIngredient: Decodable {
        let name: String
        let amount: Double?
        let unit: String?
        let original: String?
    }

    struct Instruction: Decodable {
        let name: String?
        let steps: [Step]?
    }

    struct Step: Decodable {
        let number: Int?
        let step: String?
    }
}
