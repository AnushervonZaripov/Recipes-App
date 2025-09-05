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
    
    private var trendingRecipes = ["How to shawrama at home", "How at home", "How to shawrama at home", "How to shawrama at home"]
    private var popularCategories = ["Salad", "Breakfast", "Appetizer", "Lunch"]
    private var detailedCategories = ["Chicken and Vegetable wrap", "Chicken and Vegetable wrap", "Chicken and Vegetable wrap", "Chicken and Vegetable wrap"]
    private var recentRecipes = ["Kelewele Ghanian Recipe", "Kelewele Ghanian Recipe", "Kelewele Ghanian Recipe"," Kelewele Ghanian Recipe"]
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupCollectionView()
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
                        heightDimension: .absolute(280)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.746),
                        heightDimension: .absolute(280)
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
            return detailedCategories.count
        case .recent:
            return recentRecipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .trending:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
            cell.configure(title: trendingRecipes[indexPath.item])
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.configure(title: popularCategories[indexPath.item])
            return cell
        case .detailedCategory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailedCategoryCell", for: indexPath) as! DetailedCategoryCell
            cell.configure(title: detailedCategories[indexPath.item])
            return cell
        case .recent:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentCell
            cell.configure(title: recentRecipes[indexPath.item])
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
        case 1: header.configure(title: "Popular category", buttonTitle: nil)
        case 3: header.configure(title: "Recent recipe", buttonTitle: "See all")
        default: break
        }
        return header
    }
}


extension HomeViewController: UICollectionViewDelegate {
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
                    
            
        case .trending:
            print("Tapped trending: \(trendingRecipes[indexPath.item])")
        case .detailedCategory:
            print("Tapped detailed category: \(detailedCategories[indexPath.item])")
        case .recent:
            print("Tapped recent recipe: \(recentRecipes[indexPath.item])")
        }
    }
}
