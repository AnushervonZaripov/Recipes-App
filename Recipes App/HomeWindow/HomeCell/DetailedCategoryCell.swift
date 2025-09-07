//
//  DetailedCategoryCell.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 30/08/25.
//

import UIKit

    class DetailedCategoryCell: UICollectionViewCell {
        
        private let foodImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "shawrama")
            imageView.layer.cornerRadius = 55
            return imageView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .poppinsBold(size: 14)
            label.textColor = .black
            label.numberOfLines = 2
            label.clipsToBounds = true
            label.textAlignment = .center
            return label
        }()
        
        private let cardView: UIView = {
            let cardView = UIView()
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.contentMode = .scaleAspectFill
            cardView.layer.cornerRadius = 12
            cardView.clipsToBounds = true
            cardView.backgroundColor = .neutral10
            return cardView
        }()
        
        private let timeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .neutral30
            label.font = .poppinsRegular(size: 12)
            label.text = "Time"
            return label
        }()
        
        private let cookingTimeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .neutral100
            label.font = .poppinsBold(size: 12)
            label.text = "5 Mins"
            return label
        }()
        
        private let saveButtonView: UIView = {
              var config = UIButton.Configuration.plain()
              config.image = UIImage(named: "Bookmark")
              config.background.cornerRadius = 24
              let button = UIButton(configuration: config)
              return button
        }()
        
        private let verticalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 4
            return stackView
        }()
        
        private let horizontalStack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            return stackView
        }()
        
        private let spacerView = UIView()
        private let verticalSpacerView = UIView()
        
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
            cardView.translatesAutoresizingMaskIntoConstraints = false
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            cookingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            saveButtonView.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.translatesAutoresizingMaskIntoConstraints = false
            cookingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            spacerView.translatesAutoresizingMaskIntoConstraints = false
            verticalSpacerView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        private func setupSubviews() {
            
            contentView.addSubview(cardView)
            contentView.addSubview(foodImageView)
            cardView.addSubview(verticalStackView)
            verticalStackView.addArrangedSubview(titleLabel)
            verticalStackView.addArrangedSubview(verticalSpacerView)
            verticalStackView.addArrangedSubview(timeLabel)
            verticalStackView.addArrangedSubview(horizontalStack)
            horizontalStack.addArrangedSubview(cookingTimeLabel)
            horizontalStack.addArrangedSubview(spacerView)
            horizontalStack.addArrangedSubview(saveButtonView)
        }
        
        private func setupTrendingConstraints() {
        
            NSLayoutConstraint.activate([
                cardView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                cardView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                cardView.heightAnchor.constraint(equalToConstant: 176),
                
                foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                foodImageView.heightAnchor.constraint(equalToConstant: 110),
                foodImageView.widthAnchor.constraint(equalToConstant: 110),
                foodImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
               
                verticalSpacerView.heightAnchor.constraint(equalToConstant: 8),
                
                verticalStackView.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 16),
                verticalStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
                verticalStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
                verticalStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -11),
                
                saveButtonView.heightAnchor.constraint(equalToConstant: 24),
                saveButtonView.widthAnchor.constraint(equalToConstant: 24)
                
            ])
                    }
        
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
        func configure(title: String, image: String?, time: Int) {
            titleLabel.text = title
            if let imageUrl = image, let url = URL(string: imageUrl) {
                foodImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
            } else {
                foodImageView.image = UIImage(systemName: "photo")
            }
            
            cookingTimeLabel.text = "\(time) min"
            
        }

    }

