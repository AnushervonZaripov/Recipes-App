//  RecipeDetailModel.swift
//  Recipes App
//
//  Created by Aziza Azizova on 10/09/25.
//

import Foundation

struct RecipeDetailModel: Codable {
    let id: Int
    let title: String
    let image: String?
    let summary: String?
    let readyInMinutes: Int?
    let servings: Int?
    let extendedIngredients: [ExtendedIngredient]?
    let analyzedInstructions: [Instruction]?

    struct ExtendedIngredient: Codable {
        let name: String
        let amount: Double?
        let unit: String?
        let original: String?
        let image: String? // ✅ добавлено поле для загрузки иконки
    }

    struct Instruction: Codable {
        let name: String?
        let steps: [Step]?
    }

    struct Step: Codable {
        let number: Int?
        let step: String?
    }
}
