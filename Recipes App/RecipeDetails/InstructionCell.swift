//
//  InstructionCell.swift
//  Recipes App
//
//  Created by Aziza Azizova on 30/08/25.
//

import UIKit

class InstructionCell: UIView {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(step: String, index: Int) {
        label.text = "\(index + 1). \(step)"
    }

    private func setup() {
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
