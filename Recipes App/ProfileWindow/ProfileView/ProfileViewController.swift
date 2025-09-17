//
//  ProfileViewController.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recipes: [TrendingResult] = []
    var ingredientsCountDict: [Int: Int] = [:]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupTableView()
        setupNavigationLabel()
        getTrendingRecipes()
    }
    
    private func setupNavigationLabel() {
        let navigationLabel = UILabel()
        navigationLabel.text = "Trending Now"
        navigationLabel.font = UIFont.poppinsBold(size: 24)
        navigationLabel.textColor = .neutral100
        navigationLabel.textAlignment = .center
        navigationLabel.frame = CGRect(x: 0, y: 0, width: 343, height: 29)
        navigationItem.titleView = navigationLabel
    }
    
    func setupTableView() {
        tableView.register(TrendingNowCell.self, forCellReuseIdentifier: TrendingNowCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
    }
    
    func addRecipes(_ recipe: [TrendingResult]) {
        recipes.append(contentsOf: recipe)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingNowCell.identifier, for: indexPath) as? TrendingNowCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row]
        let recipeId = recipe.id ?? 0
        
        if let count = ingredientsCountDict[recipeId] {
            cell.configure(title: recipe.title ?? "", imageUrl: recipe.image, ingredientsNumber: count, cookingTime: recipe.maxReadyTime ?? 0)
        } else {
            cell.configure(title: recipe.title ?? "", imageUrl: recipe.image, ingredientsNumber: 0, cookingTime: recipe.maxReadyTime ?? 0)
            
            NetworkManager.shared.getRecipeIngredientsCount(recipeId: recipeId) { [weak self] result in
                switch result {
                case .success(let recipeInfo):
                    let count = recipeInfo.extendedIngredients.count
                    self?.ingredientsCountDict[recipeId] = count
                    DispatchQueue.main.async {
                        if let visibleCell = tableView.cellForRow(at: indexPath) as? TrendingNowCell {
                            visibleCell.configure(title: recipe.title ?? "", imageUrl: recipe.image, ingredientsNumber: count, cookingTime: recipe.maxReadyTime ?? 0)
                        }
                    }
                case .failure(let error):
                    print("Ошибка получения ингредиентов для \(recipe.title ?? ""): \(error)")
                }
            }
        }
        
        return cell
    }
    
    // MARK: - Networking
    
    func getTrendingRecipes() {
        NetworkManager.shared.getTrendingRecipes { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.addRecipes(recipes.results ?? [])
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
