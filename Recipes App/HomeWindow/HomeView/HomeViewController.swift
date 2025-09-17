//
//  HomeViewController.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
}

class HomeViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case trending
        case categories
        case detailedCategory
        case recent
    }
    private let savedStorage = SavedRecipesStorage()
    
    private let mainLabel: UILabel = {
       let label = UILabel()
        label.text = "Get amazing recipes for cooking"
        label.font = .poppinsBold(size: 24)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search recipes"
        textField.tintColor = .neutral50
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
       return textField
    }()
    

    private var popularCategories = [
        "Main Course",
        "Side Dish",
        "Dessert",
        "Appetizer",
        "Salad",
        "Bread",
        "Breakfast",
        "Soup",
        "Beverage",
        "Sauce",
        "Marinade",
        "Fingerfood",
        "Snack",
        "Drink"
    ]

    private var recentRecipes: [RecentResult] = []
    
    private var trendingRecipes: [TrendingResult] = []
    private var popularRecipes: [TrendingResult] = []
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupSubviews()
        setupConstraints()
        setupCollectionView()
        getTrendingRecipes()
        hideKeyboardWhenTappedAround()
        if let firstCategory = popularCategories.first {
               fetchRecipes(for: firstCategory)
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTrendingRecipes()
    }

    private func setupSubviews() {
        view.addSubview(mainLabel)
        view.addSubview(searchTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 28),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self

        view.addSubview(collectionView)

        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(DetailedCategoryCell.self, forCellWithReuseIdentifier: "DetailedCategoryCell")
        collectionView.register(RecentCell.self, forCellWithReuseIdentifier: "RecentCell")
        collectionView.register(HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView")
        
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .trending:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension:  .estimated(280)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.746),
                        heightDimension: .estimated(280)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0)

                section.boundarySupplementaryItems = [self.makeHeader()]
                return section
                
            case .categories:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(36)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.32),
                        heightDimension: .absolute(36)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 19, trailing: 0)
                section.boundarySupplementaryItems = [self.makeHeader()]
                return section
                
            case .detailedCategory:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(231)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.4),
                        heightDimension: .absolute(231)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 22, trailing: 0)

                return section
                
            case .recent:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(190)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.33),
                        heightDimension: .absolute(190)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 19, leading: 0, bottom: 40, trailing: 0)
                section.boundarySupplementaryItems = [self.makeHeader()]
                return section
            }
        }
    }

    private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}

// MARK: - DataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .trending:
            return trendingRecipes.count
        case .categories:
            return popularCategories.count
        case .detailedCategory:
            return popularRecipes.count
        case .recent:
            return recentRecipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .trending:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "TrendingCell",
                for: indexPath
            ) as! TrendingCell
            let recipe = trendingRecipes[indexPath.item]
            cell.configure(with: recipe)
            cell.onSaveTapped = { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadItems(at: [indexPath])
            }

            return cell


        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
                       cell.configure(title: popularCategories[indexPath.item])
            return cell
        case .detailedCategory:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "DetailedCategoryCell",
                for: indexPath
            ) as! DetailedCategoryCell
            if popularRecipes.indices.contains(indexPath.item) {
                let recipe = popularRecipes[indexPath.item]
                cell.configure(with: recipe)  // ← важно!
            }
            
            cell.onSaveTapped = { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadItems(at: [indexPath])
            }
            return cell


        case .recent:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "RecentCell",
                    for: indexPath
                ) as! RecentCell
                let recipe = recentRecipes[indexPath.item]
                cell.configure(title: recipe.title ?? "")
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "HeaderView",
            for: indexPath
        ) as! HeaderView
        
        switch indexPath.section {
        case 0: header.configure(title: "Trending now 🔥", buttonTitle: "See all")
            header.delegate = self
        case 1: header.configure(title: "Popular category", buttonTitle: nil)
            header.delegate = self
        case 3: header.configure(title: "Recent recipe", buttonTitle: "See all")
            header.delegate = self
        default: break
        }
        return header
    }
    
    @objc private func goToTrendingSection() {
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 4 
            }
        }
}



extension HomeViewController: UICollectionViewDelegate, HeaderViewDelegate {
    func didTapHeaderButton(_ header: HeaderView) {
        goToTrendingSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .categories:
            
                    for item in 0..<popularCategories.count {
                        if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: Section.categories.rawValue)) {
                            cell.backgroundColor = .clear
                        }
                    }
                    
                    if let cell = collectionView.cellForItem(at: indexPath) {
                        cell.backgroundColor = .primary50
                        cell.layer.cornerRadius = 10
                    }
            
          
            let selectedCategory = popularCategories[indexPath.item]
                fetchRecipes(for: selectedCategory)
                    
            
        case .trending:
            let selectedRecipe = trendingRecipes[indexPath.item]
            guard let recipeId = selectedRecipe.id else {
                print("❌ Нет ID у рецепта")
                return
            }
            let detailVC = RecipeDetailViewController(recipeId: recipeId)
            navigationController?.pushViewController(detailVC, animated: true)

        case .detailedCategory:
            let selectedRecipe = popularRecipes[indexPath.item]
            guard let recipeId = selectedRecipe.id else {
                print("❌ Нет ID у рецепта")
                return
            }
            let detailVC = RecipeDetailViewController(recipeId: recipeId)
            navigationController?.pushViewController(detailVC, animated: true)

        case .recent:
            let selectedRecipe = recentRecipes[indexPath.item]
            guard let recipeId = selectedRecipe.id else {
                print("❌ Нет ID у рецепта")
                return
            }
            let detailVC = RecipeDetailViewController(recipeId: recipeId)
            navigationController?.pushViewController(detailVC, animated: true)

        }
    }
    
    func getTrendingRecipes() {
        NetworkManager.shared.getTrendingRecipes { [weak self] result in
            switch result {
            case .success(let trending):
                print("✅ Получено с бэка: \(trending.results?.count ?? 0) рецептов")
                DispatchQueue.main.async {
                    self?.trendingRecipes = trending.results ?? []
                    let ids = trending.results?.map { $0.id } ?? []
                    self?.collectionView.reloadData()
                }

            case .failure(let error):
                print("Error fetching trending recipes: \(error)")
            }
        }
    }
    
    private func fetchRecipes(for category: String) {
        NetworkManager.shared.getPopularRecipes(type: category) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.popularRecipes = data.results ?? [TrendingResult]()
                    self?.collectionView.reloadSections(IndexSet(integer: Section.detailedCategory.rawValue))
                }
            case .failure(let error):
                print("❌ Error fetching recipes for \(category):", error)
            }
        }
    }
}
