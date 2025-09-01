//
//  IngredientCell.swift
//  Recipes App
//
//  Created by Aziza Azizova on 30/08/25.
//
import UIKit

class IngredientCell: UIView {

    private let container = UIView()
    private let iconView = UIImageView()
    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let innerStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with ingredient: Ingredient, imageName: String) {
        iconView.image = UIImage(named: imageName)
        nameLabel.text = ingredient.name
        quantityLabel.text = ingredient.quantity
    }

    private func setup() {
        // Серый контейнер
        container.backgroundColor = .neutral10
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: 76)
        ])

        // Иконка
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 4
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 32).isActive = true

        // Название
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = .black

        // Граммовка
        quantityLabel.font = .systemFont(ofSize: 16)
        quantityLabel.textColor = .gray
        quantityLabel.setContentHuggingPriority(.required, for: .horizontal)

        // Горизонтальный стек
        innerStack.axis = .horizontal
        innerStack.spacing = 12
        innerStack.alignment = .center
        innerStack.translatesAutoresizingMaskIntoConstraints = false
        innerStack.addArrangedSubview(iconView)
        innerStack.addArrangedSubview(nameLabel)
        innerStack.addArrangedSubview(quantityLabel)

        container.addSubview(innerStack)

        NSLayoutConstraint.activate([
            innerStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            innerStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
            innerStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            innerStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
}
