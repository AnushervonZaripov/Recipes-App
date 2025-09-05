//
//  FavoritsTableViewCell.swift
//  Recipes App
//
//  Created by ASD on 21/08/25.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    static let identifier = "RecipeCell"
    
    var recipeImageView = UIImageView()
    var  titleLabel = UILabel()
    var deleteButton = UIButton(type: .system)
    var time = UILabel()
    var rating = UIView()
    
    var onDelete: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupRecipeImageView()
        setupTitleLabel()
        setupDeleteButton()
        setupTime()
        setupRating()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubviews() {
        [recipeImageView, titleLabel, deleteButton, time, rating].forEach {contentView.addSubview($0)}
    }
    
    private func setupRecipeImageView() {
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTime() {
        time.text = "15:10"
        time.textColor = .white0
        time.textAlignment = .center
        time.backgroundColor = .neutral40
        time.clipsToBounds = true
        time.layer.cornerRadius = 8
        time.font = .poppinsRegular(size: 12)
        time.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupRating() {
        let ratingStar = UIImageView(image: UIImage(named: "ratingStar"))
        ratingStar.tintColor = .neutral100
        ratingStar.contentMode = .scaleAspectFit
        
        let ratingLabel = UILabel()
        ratingLabel.text = "5,0"
        ratingLabel.textColor = .white0
        ratingLabel.font = .poppinsBold(size: 14)
        
        let stackView = UIStackView(arrangedSubviews: [ratingStar, ratingLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        rating.addSubview(stackView)
        rating.backgroundColor = .neutral60
        rating.layer.cornerRadius = 8
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: rating.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: rating.centerYAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.poppinsBold(size: 18)
        titleLabel.numberOfLines = 2
        titleLabel.text = "How to make Shavarma at Home"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupDeleteButton() {
        deleteButton.setImage(UIImage(named: "savedIcon"), for: .normal)
        deleteButton.tintColor = .primary50
        deleteButton.backgroundColor = .primary10
        deleteButton.layer.cornerRadius = 16
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -25),
            recipeImageView.widthAnchor.constraint(equalToConstant: 343),
            recipeImageView.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 343),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            deleteButton.rightAnchor.constraint(equalTo: recipeImageView.rightAnchor, constant: -4),
            deleteButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 4),
            deleteButton.widthAnchor.constraint(equalToConstant: 32),
            deleteButton.heightAnchor.constraint(equalToConstant: 32),
            
            time.rightAnchor.constraint(equalTo: recipeImageView.rightAnchor, constant: -4),
            time.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: -4),
            time.widthAnchor.constraint(equalToConstant: 41),
            time.heightAnchor.constraint(equalToConstant: 25),
            
            rating.leftAnchor.constraint(equalTo: recipeImageView.leftAnchor, constant: 4),
            rating.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 4),
            rating.widthAnchor.constraint(equalToConstant: 58),
            rating.heightAnchor.constraint(equalToConstant: 27.6)
        ])
    }
    
    @objc private func deleteTapped() {
        onDelete?()
    }
    
    func configure(with recipe: Recipes, onDelete: @escaping () -> Void) {
        recipeImageView.image = recipe.image
        titleLabel.text = recipe.title
        self.onDelete = onDelete
    }
}
