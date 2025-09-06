//
//  TrendingNowCell.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 05/09/25.
//

import UIKit

class TrendingNowCell: UITableViewCell {
    static let identifier = "TrendingNowCell"
    
    private let recipeImageView = UIImageView()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor, // тёмный низ
        ]
        layer.locations = [0.0, 1.0]
        return layer
    }()


    private let ingredientsNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = .poppinsRegular(size: 12)
        lbl.text = "9 ingredients  |  25 min"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let rating = UIView()
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "How to make yam & vegetable sauce at home"
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = .white
        lbl.font = .poppinsBold(size: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let verticalStack: UIStackView = {
        let hs = UIStackView()
        hs.axis = .vertical
        hs.distribution = .fill
        hs.spacing = 8
        hs.alignment = .leading
        hs.translatesAutoresizingMaskIntoConstraints = false
        return hs
    }()
    
    var onDelete: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setupRecipeImageView()
        setupRating()
        makeConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = recipeImageView.bounds.height
        gradientLayer.frame = CGRect(
            x: 0,
            y: height * 0.7,
            width: recipeImageView.bounds.width,
            height: height * 0.3
        )
    }

    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubviews() {
        [recipeImageView, rating].forEach {contentView.addSubview($0)}
        recipeImageView.layer.addSublayer(gradientLayer)
        [verticalStack].forEach{recipeImageView.addSubview($0)}
        [titleLabel, ingredientsNumberLabel].forEach { verticalStack.addArrangedSubview($0)}
    }
    
    private func setupRecipeImageView() {
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            verticalStack.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 15),
            verticalStack.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: -16),
            verticalStack.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -15),

//            verticalStack.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -),
            
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
        self.onDelete = onDelete
    }
    
    func transferRecipesImage() -> UIImageView {
        var imageView = UIImageView()
        imageView = recipeImageView
        return imageView
    }
}
