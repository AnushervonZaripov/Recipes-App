//
//  UIButton + ext.swift
//  Recipes App
//
//  Created by ASD on 18/08/25.
//

import UIKit

extension UIButton {
    static func makeButton(text: String,
                           font: UIFont,
                           size: CGSize,
                           cornerRadius: CGFloat = 0) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = font
        button.tintColor = .white
        button.backgroundColor = .primary50
        button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
