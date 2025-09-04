//
//  RecipeDetailHeaderView.swift
//  Recipes App
//
//  Created by Aziza Azizova on 30/08/25.
//

import UIKit

class RecipeDetailHeaderView: UIView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with recipe: Recipe) {
        imageView.image = UIImage(named: recipe.imageName)
        titleLabel.text = recipe.title
        ratingLabel.text = "⭐️ \(recipe.rating) (\(recipe.reviewsCount) reviews)"
    }

    private func setup() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0

        ratingLabel.font = .systemFont(ofSize: 16)
        ratingLabel.textColor = .gray

        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, ratingLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
