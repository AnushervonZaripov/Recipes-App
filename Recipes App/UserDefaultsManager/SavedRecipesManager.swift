//
//  SavedRecipesManager.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 08/09/25.
//

import Foundation

final class SavedRecipesStorage {
    private let key = "savedRecipes"
    private let defaults = UserDefaults.standard
    
    func saveRecipe(_ recipe: TrendingResult) {
        var saved = getSavedRecipes()
        if !saved.contains(where: { $0.id == recipe.id }) {
            saved.append(recipe)
            saveArray(saved)
        }
    }
    
    func removeRecipe(_ recipe: TrendingResult) {
        var saved = getSavedRecipes()
        saved.removeAll { $0.id == recipe.id }
        saveArray(saved)
    }
    
    func getSavedRecipes() -> [TrendingResult] {
        guard let data = defaults.data(forKey: key) else { return [] }
        let decoder = JSONDecoder()
        return (try? decoder.decode([TrendingResult].self, from: data)) ?? []
    }
    
    func isSaved(_ recipe: TrendingResult) -> Bool {
        getSavedRecipes().contains { $0.id == recipe.id }
    }
    
    private func saveArray(_ array: [TrendingResult]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(array) {
            defaults.set(data, forKey: key)
        }
    }
}
