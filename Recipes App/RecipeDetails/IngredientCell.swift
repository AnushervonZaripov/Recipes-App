import UIKit

final class IngredientCell: UIView {

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

    func configure(with ingredient: Ingredient) {
        nameLabel.text = ingredient.name
        quantityLabel.text = ingredient.quantity

        if let urlStr = ingredient.imageURL {
            ImageLoader.shared.load(
                urlStr,
                into: iconView,
                placeholder: UIImage(named: "ingredient_placeholder")
            )
        } else {
            iconView.image = UIImage(named: "ingredient_placeholder")
        }
    }

    private func setup() {
        // Серый контейнер
        container.backgroundColor = UIColor.systemGray5
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
        nameLabel.numberOfLines = 2
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        // Граммовка
        quantityLabel.font = .systemFont(ofSize: 16)
        quantityLabel.textColor = .gray
        quantityLabel.textAlignment = .right
        quantityLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
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
