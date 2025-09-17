//
//  HeaderView.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 25/08/25.
//


import UIKit


protocol HeaderViewDelegate: AnyObject {
    func didTapHeaderButton(_ header: HeaderView)
}

class HeaderView: UICollectionReusableView {
    private let titleLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    
    weak var delegate: HeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.setTitleColor(.systemRed, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, buttonTitle: String?) {
        titleLabel.text = title
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.isHidden = (buttonTitle == nil)
        actionButton.addTarget(self, action: #selector(buttonTappedCasual), for: .touchUpInside)
    }
    
    @objc private func buttonTappedCasual() {
        delegate?.didTapHeaderButton(self)
    }

}
