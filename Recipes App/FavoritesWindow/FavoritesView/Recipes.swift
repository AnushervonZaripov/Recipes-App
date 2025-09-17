

import UIKit

struct Recipes: Codable {
    let id: Int
    let title: String
    let imageName: String

    var image: UIImage? {
        UIImage(named: imageName)
    }
}



