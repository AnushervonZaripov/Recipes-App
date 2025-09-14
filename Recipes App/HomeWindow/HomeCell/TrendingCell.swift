//
//  TrendingCell.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 25/08/25.
//

import UIKit
import SDWebImage

class TrendingCell: UICollectionViewCell {
    
    var onSaveTapped: (() -> Void)?
    private var recipe: TrendingResult?
    private let savedStorage = SavedRecipesStorage()
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "shawrama")
        imageView.layer.cornerRadius = 12
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 16)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral50
        label.font = .poppinsRegular(size: 12)
        return label
    }()
    
    private let saveButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Bookmark")
        let button = UIButton(configuration: config)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        setupSubviews()
        setupConstraints()
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor, multiplier: 0.75),
            
            titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            saveButton.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -8),
            saveButton.widthAnchor.constraint(equalToConstant: 32),
            saveButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(with recipe: TrendingResult) {
        self.recipe = recipe
        titleLabel.text = recipe.title ?? ""
        authorNameLabel.text = "By \(recipe.author ?? "Unknown")"
        
        if let urlString = recipe.image, let url = URL(string: urlString) {
            foodImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            foodImageView.image = UIImage(systemName: "photo")
        }
        
        setSavedState(savedStorage.isSaved(recipe))
    }
    
    @objc private func saveTapped() {
        guard let recipe = recipe else { return }
        if savedStorage.isSaved(recipe) {
            savedStorage.removeRecipe(recipe)
            setSavedState(false)
        } else {
            savedStorage.saveRecipe(recipe)
            setSavedState(true)
        }
        onSaveTapped?()
    }
    
    private func setSavedState(_ saved: Bool) {
        let imageName = saved ? "Active" : "Bookmark"
        saveButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
