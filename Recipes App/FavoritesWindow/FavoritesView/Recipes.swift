import UIKit


struct Recipes: Codable {
    let id: UUID
    let title: String
    let imageName: String

    var image: UIImage? {
        UIImage(named: imageName)
    }
}

class FavoritesStorage {
    static var items: [Recipes] = []
}


