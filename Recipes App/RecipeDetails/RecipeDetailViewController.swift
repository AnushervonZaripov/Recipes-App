//
//  RecipeDetailViewController.swift
//  Recipes App
//
//  Created by Aziza Azizova on 30/08/25.
//

import UIKit

class RecipeDetailViewController: UIViewController, RecipeDetailView {

    private let presenter = RecipeDetailPresenter()

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let headerView = RecipeDetailHeaderView()
    private let ingredientsStack = UIStackView()
    private let instructionsStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.attachView(self)
        presenter.loadMockRecipe()
    }

    func display(recipe: Recipe) {
        headerView.configure(with: recipe)

        ingredientsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for ingredient in recipe.ingredients {
            let cell = IngredientCell()
            cell.configure(with: ingredient, imageName: recipe.imageName)
            ingredientsStack.addArrangedSubview(cell)
        }


        instructionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (index, step) in recipe.instructions.enumerated() {
            let cell = InstructionCell()
            cell.configure(step: step, index: index)
            instructionsStack.addArrangedSubview(cell)
        }
    }

    private func setupUI() {
        view.backgroundColor = .white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentStack.axis = .vertical
        contentStack.spacing = 24
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        ingredientsStack.axis = .vertical
        ingredientsStack.spacing = 12

        instructionsStack.axis = .vertical
        instructionsStack.spacing = 12

        contentStack.addArrangedSubview(headerView) // фото, заголовок, рейтинг
        contentStack.addArrangedSubview(makeSectionTitle("Instructions"))
        contentStack.addArrangedSubview(instructionsStack)
        contentStack.addArrangedSubview(makeSectionTitle("Ingredients (5 items)"))
        contentStack.addArrangedSubview(ingredientsStack)
      


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func makeSectionTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }
}

