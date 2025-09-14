// RecipeDetailViewController.swift
import UIKit

class RecipeDetailViewController: UIViewController, RecipeDetailView {

    private let presenter = RecipeDetailPresenter()

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let headerView = RecipeDetailHeaderView()
    private let ingredientsStack = UIStackView()
    private let instructionsStack = UIStackView()

    private let recipeId: Int

    init(recipeId: Int) {
        self.recipeId = recipeId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.attachView(self)
        presenter.loadRecipe(id: recipeId)
    }

    func display(recipe: Recipe) {
        headerView.configure(with: recipe)

        ingredientsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for ingredient in recipe.ingredients {
            let cell = IngredientCell()
            cell.configure(with: ingredient)
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

        contentStack.addArrangedSubview(headerView)
        contentStack.addArrangedSubview(makeSectionTitle("Instructions"))
        contentStack.addArrangedSubview(instructionsStack)
        contentStack.addArrangedSubview(makeSectionTitle("Ingredients"))
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

    // Получаем данные из сети и маппим в UI-модель
    func render(model: RecipeDetailModel) {
        title = model.title

        let recipe = mapToRecipe(from: model)
        display(recipe: recipe)

        ingredientsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        model.extendedIngredients?.forEach { ingredient in
            let qty = "\(Int(ingredient.amount ?? 0)) \(ingredient.unit ?? "")"
            let imageURL = makeIngredientImageURL(ingredient.image)
            let cell = IngredientCell()
            cell.configure(with: Ingredient(name: ingredient.name, quantity: qty, imageURL: imageURL))
            ingredientsStack.addArrangedSubview(cell)
        }

        instructionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let steps = model.analyzedInstructions?.first?.steps {
            for (index, step) in steps.enumerated() {
                let cell = InstructionCell()
                cell.configure(step: step.step ?? "", index: index)
                instructionsStack.addArrangedSubview(cell)
            }
        }
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }

    private func mapToRecipe(from model: RecipeDetailModel) -> Recipe {
        let ingredients: [Ingredient] = model.extendedIngredients?.map {
            let quantity = "\(Int($0.amount ?? 0)) \($0.unit ?? "")"
            return Ingredient(
                name: $0.name,
                quantity: quantity,
                imageURL: makeIngredientImageURL($0.image)
            )
        } ?? []

        let instructions: [String] = model.analyzedInstructions?.first?.steps?.compactMap { $0.step } ?? []

        return Recipe(
            title: model.title,
            imageURL: model.image, // ожидается полный URL от API
            rating: 4.5,           // TODO: если появится рейтинг — подставить
            reviewsCount: 120,     // TODO: реальное значение по данным
            ingredients: ingredients,
            instructions: instructions
        )
    }

    private func makeIngredientImageURL(_ imageName: String?) -> String? {
        guard let imageName, !imageName.isEmpty else { return nil }
        // Документация Spoonacular: cdn/ingredients_100x100
        return "https://spoonacular.com/cdn/ingredients_100x100/\(imageName)"
    }
}
