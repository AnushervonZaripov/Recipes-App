//
//  RecipeDetailPresenter.swift
//  Recipes App
//
//  Created by Aziza Azizova on 30/08/25.
//

import Foundation

protocol RecipeDetailView: AnyObject {
    func display(recipe: Recipe)
}

class RecipeDetailPresenter {
    weak var view: RecipeDetailView?

    func attachView(_ view: RecipeDetailView) {
        self.view = view
    }

    func loadMockRecipe() {
        let mockRecipe = Recipe(
            title: "Tasty Fish (Point & Kill)",
            imageName: "fish_dish",
            rating: 4.5,
            reviewsCount: 300,
            ingredients: [
                Ingredient(name: "Fish", quantity: "200g"),
                Ingredient(name: "Ginger", quantity: "100g"),
                Ingredient(name: "Vegetable Oil", quantity: "80g"),
                Ingredient(name: "Salt", quantity: "100g"),
                Ingredient(name: "Cucumber", quantity: "200g")
            ],
            instructions: [
                "Place eggs in a saucepan and cover with cold water.",
                "Bring water to a boil and remove from heat.",
                "Let eggs stand for 10–12 minutes, then peel and chop.",
                "Add chopped tomatoes, corn, lettuce, and other vegetables.",
                "Stir in mayo, green onion, mustard, and seasonings."
            ]
        )
        view?.display(recipe: mockRecipe)
    }
}

