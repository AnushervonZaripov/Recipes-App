//
//  TrendingCell.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 25/08/25.
//

import UIKit
import SDWebImage

class TrendingCell: UICollectionViewCell {
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "shawrama")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let authorImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(named: "avatarImage")
        avatarImageView.layer.cornerRadius = 16
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral50
        label.font = .poppinsRegular(size: 12)
        label.text = "By Zeelecious Foods"
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let starButtonView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .neutral30
        view.layer.opacity = 0.66
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let saveButtonView: UIView = {
          var config = UIButton.Configuration.plain()
          config.image = UIImage(named: "Bookmark")
          config.background.cornerRadius = 24
          let button = UIButton(configuration: config)
          return button
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .poppinsRegular(size: 14)
        label.text = "4.6"
        return label
    }()
    
    private let spacerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        switchOffAuthoresizingMask()
        setupSubviews()
        setupTrendingConstraints()
    }
    
    private func switchOffAuthoresizingMask() {
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        starButtonView.translatesAutoresizingMaskIntoConstraints = false
        saveButtonView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubviews() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorImageView)
        contentView.addSubview(authorNameLabel)
        foodImageView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(starButtonView)
        buttonStackView.addArrangedSubview(spacerView)
        buttonStackView.addArrangedSubview(saveButtonView)
        starButtonView.addSubview(starImageView)
        starButtonView.addSubview(ratingLabel)
    }
    
    private func setupTrendingConstraints() {
    
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             
             // высота = ширина * 0.75 (4:3)
            foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor, multiplier: 0.75),
        
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//               titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
               titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 8),
            
            authorImageView.widthAnchor.constraint(equalToConstant: 32),
            authorImageView.heightAnchor.constraint(equalToConstant: 32),
            authorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 8),
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.5),
            
            starButtonView.heightAnchor.constraint(equalToConstant: 27.6),
            starButtonView.widthAnchor.constraint(equalToConstant: 58),
            
            buttonStackView.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 8),
            buttonStackView.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor, constant: 8),
            buttonStackView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -8),
            
            starImageView.widthAnchor.constraint(equalToConstant: 12),
            starImageView.heightAnchor.constraint(equalToConstant: 12),
            starImageView.leadingAnchor.constraint(equalTo: starButtonView.leadingAnchor, constant: 10),
            starImageView.topAnchor.constraint(equalTo: starButtonView.topAnchor, constant: 7.8),
        
            ratingLabel.topAnchor.constraint(equalTo: starButtonView.topAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 3),
            
            saveButtonView.heightAnchor.constraint(equalToConstant: 32),
            saveButtonView.widthAnchor.constraint(equalToConstant: 32)
        ])

    }

#warning("required init лучше оставлять прямо под основным")
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(title: String, imageUrl: String?, authName: String) {
        titleLabel.text = title
        authorNameLabel.text = authName
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            foodImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            foodImageView.image = UIImage(systemName: "photo")
        }
    }
}
