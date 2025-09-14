
import Foundation

import Foundation

struct Recipe {
    let title: String?
    let imageURL: String?
    let rating: Double
    let reviewsCount: Int
    let ingredients: [Ingredient]
    let instructions: [String]
}

struct Ingredient {
    let name: String?
    let quantity: String
    let imageURL: String?   
}
