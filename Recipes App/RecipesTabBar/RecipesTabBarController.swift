//
//  RecipesTabBar.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//

import UIKit

class RecipesTabBarController: UITabBarController {
    
    private let middleButton: UIButton = {
           let button = UIButton()
           button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.tintColor = .black
        button.backgroundColor = .primary50
           button.tintColor = .white
           button.layer.cornerRadius = 32
           button.layer.shadowColor = UIColor.black.cgColor
           button.layer.shadowOpacity = 0.2
           button.layer.shadowOffset = CGSize(width: 0, height: 4)
           button.layer.shadowRadius = 6
           return button
       }()
    
    private let customTabBar = RecipesTabBar()
 
       override func loadView() {
           super.loadView()
           self.setValue(customTabBar, forKey: "tabBar")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleButton()
        setUpTabBar()
    }
    
    private func setupMiddleButton() {
           let buttonSize: CGFloat = 48
           middleButton.frame = CGRect(
               x: (view.bounds.width - buttonSize) / 2,
               y: -25,
               width: buttonSize,
               height: buttonSize
           )
           middleButton.layer.cornerRadius = buttonSize / 2
           tabBar.addSubview(middleButton)

           middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
       }

       @objc private func middleButtonTapped() {
           print("➕ Tapped")
       }
    
    private func setUpTabBar() {
        tabBar.tintColor = .primary50
        tabBar.unselectedItemTintColor = .neutral40
   
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "menuIcon")?.withRenderingMode(.alwaysTemplate), tag: 0)
        
        let favVC = UINavigationController(rootViewController: FavoritesViewController())
        favVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "savedIcon")?.withRenderingMode(.alwaysTemplate), tag: 1)
        
        
        let emptyVC = UIViewController()
        emptyVC.tabBarItem.isEnabled = false
        
        let notificationVC = UINavigationController(rootViewController: NotificationViewController())
        notificationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ringIcon")?.withRenderingMode(.alwaysTemplate), tag: 2)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profileIcon")?.withRenderingMode(.alwaysTemplate), tag: 3)
    
        viewControllers = [homeVC, favVC, emptyVC, notificationVC, profileVC]
    }
}
