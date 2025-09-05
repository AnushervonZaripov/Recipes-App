//
//  RecentCell.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 25/08/25.
//
import UIKit

class RecentCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "shawrama")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral50
        label.font = .poppinsRegular(size: 12)
        label.text = "By Zeelecious Foods"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        switchOffAuthorisizing()
        setupSubviews()
        setupConstraints()
    }
    
    private func switchOffAuthorisizing() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 124),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            authorNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

