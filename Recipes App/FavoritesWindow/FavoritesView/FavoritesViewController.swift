//
//  FavoritesViewController.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//
import UIKit

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let storage = SavedRecipesStorage()
    private var recipes: [TrendingResult] = [] 
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        setupTableView()
        setupNavigationLabel()
        loadSavedRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedRecipes() // обновляем при возврате
    }
    
    private func loadSavedRecipes() {
        recipes = storage.getSavedRecipes() // получаем объекты
        tableView.reloadData()
    }
    
    private func setupNavigationLabel() {
        let navigationLabel = UILabel()
        navigationLabel.text = "Saved Recipes"
        navigationLabel.font = UIFont.poppinsBold(size: 24)
        navigationLabel.textColor = .neutral100
        navigationLabel.textAlignment = .left
        navigationLabel.frame = CGRect(x: 0, y: 0, width: 343, height: 29)
        navigationItem.titleView = navigationLabel
    }
    
    func setupTableView() {
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250
        tableView.frame = view.bounds
    }
    
    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoritesTableViewCell.identifier,
            for: indexPath
        ) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe) // передаем реальный объект
        
        cell.onDelete = { [weak self] in
            guard let self = self else { return }
            self.storage.removeRecipe(recipe)
            self.loadSavedRecipes()
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
