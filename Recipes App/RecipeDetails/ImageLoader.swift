//
//  ImageLoader.swift
//  Recipes App
//
//  Created by Aziza Azizova on 14/09/25.
//


import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func load(_ urlString: String?, into imageView: UIImageView, placeholder: UIImage? = nil) {
        imageView.image = placeholder

        guard
            let urlString = urlString,
            let url = URL(string: urlString)
        else {
            return
        }

        if let cached = cache.object(forKey: url as NSURL) {
            imageView.image = cached
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self, let data, error == nil, let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}
