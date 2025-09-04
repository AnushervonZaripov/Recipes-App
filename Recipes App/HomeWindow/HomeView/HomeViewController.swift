//
//  HomeViewController.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//

import UIKit

//временно поставила тут кнопку, чтобы смотреть детали рецепта

class HomeViewController: UIViewController {

    private let showDetailButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
    }

    private func setupButton() {
        showDetailButton.setTitle("Show Recipe Detail", for: .normal)
        showDetailButton.titleLabel?.font = .systemFont(ofSize: 18)
        showDetailButton.setTitleColor(.white, for: .normal)
        showDetailButton.backgroundColor = .systemBlue
        showDetailButton.layer.cornerRadius = 10
        showDetailButton.translatesAutoresizingMaskIntoConstraints = false
        showDetailButton.addTarget(self, action: #selector(showDetailTapped), for: .touchUpInside)

        view.addSubview(showDetailButton)

        NSLayoutConstraint.activate([
            showDetailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showDetailButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showDetailButton.widthAnchor.constraint(equalToConstant: 200),
            showDetailButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func showDetailTapped() {
        let detailVC = RecipeDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
