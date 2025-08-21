//
//  WeatherCardView.swift
//  SunPeek
//
//  Created by Aziza Azizova on 02/08/25.
//

import UIKit

class WeatherCardView: UIView {
    private let dayLabel = UILabel()
    private let iconView = UIImageView()
    private let tempLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = 12
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)

        let stack = UIStackView(arrangedSubviews: [dayLabel, iconView, tempLabel, descriptionLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .label
        dayLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tempLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
    }

    func configure(with model: DailyWeather) {
        let date = Date(timeIntervalSince1970: model.dt)
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        dayLabel.text = formatter.string(from: date)

        tempLabel.text = "\(Int(model.temp.day))°C"
        descriptionLabel.text = model.weather.first?.main.capitalized ?? "—"
        iconView.image = UIImage(systemName: systemIcon(for: model.weather.first?.icon ?? "01d"))
    }

    private func systemIcon(for iconCode: String) -> String {
        // Примеры конверсии OpenWeather icons -> SF Symbols
        switch iconCode {
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

