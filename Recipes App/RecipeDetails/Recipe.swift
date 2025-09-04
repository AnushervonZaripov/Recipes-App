//
//  Recipe.swift
//  Recipes App
//
//  Created by Aziza Azizova on 30/08/25.
//

import Foundation

struct Recipe {
    let title: String
    let imageName: String
    let rating: Double
    let reviewsCount: Int
    let ingredients: [Ingredient]
    let instructions: [String]
}

struct Ingredient {
    let name: String
    let quantity: String
}

