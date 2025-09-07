//
//  FavoritesViewController.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//
import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var recipes: [Recipes] = []
    let tableView = UITableView()
    var images = [UIImage(named: "savedRecipe1"), UIImage(named: "savedRecipe2"), UIImage(named: "savedRecipe3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupTableView()
        setupNavigationLabel()
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
    
    func addRecipes(_ recipe: Recipes) {
        recipes.append(recipe)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.recipeImageView.image = images[indexPath.row]
        
        return cell
    }
}
