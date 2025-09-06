//
//  ProfileViewController.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    
    func addRecipes(_ recipe: Recipes) {
        recipes.append(recipe)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingNowCell.identifier, for: indexPath) as? TrendingNowCell else {
            return UITableViewCell()
        }
        
        cell.transferRecipesImage().image = images[indexPath.row]
//
//        let recipe = recipes[indexPath.row]
//        cell.configure(with: recipe) { [weak self] in
//            self?.recipes.remove(at: indexPath.row)
//            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
        
        return cell
    }
}
