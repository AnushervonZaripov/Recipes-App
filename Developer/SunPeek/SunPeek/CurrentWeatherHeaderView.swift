//
//  CurrentWeatherHeaderView.swift
//  SunPeek
//
//  Created by Aziza Azizova on 02/08/25.
//

import UIKit

class CurrentWeatherHeaderView: UIView {
    private let tempLabel = UILabel()
    private let iconView = UIImageView()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(with model: CurrentWeather) {
        tempLabel.text = "\(Int(model.temp))°C"
        descriptionLabel.text = model.weather.first?.main.capitalized
        iconView.image = UIImage(systemName: systemIcon(for: model.weather.first?.icon ?? "01d"))
    }

    private func setup() {
        iconView.tintColor = .label
        tempLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)

        let stack = UIStackView(arrangedSubviews: [iconView, tempLabel, descriptionLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func systemIcon(for code: String) -> String {
        switch code {
        case "01d": return "sun.max"
        case "01n": return "moon"
        case "02d": return "cloud.sun"
        case "02n": return "cloud.moon"
        case "09d", "10d": return "cloud.rain"
        case "11d": return "cloud.bolt"
        default: return "cloud"
        }
    }
}
