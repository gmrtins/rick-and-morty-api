//
//  MainViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import UIKit

class MainViewController: UITabBarController {
    let charactersVC = CharactersViewController(viewModel: CharactersViewModel())
    let aboutVC = AboutViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTabBarItems()
        configureTabBar()
    }
        
    func configureTabBar() {
        tabBar.tintColor = UIColor(hex: "#7cf448")
        
        tabBar.barTintColor = .gray
        setViewControllers([charactersVC, aboutVC], animated: true)
        let appearance = UITabBarAppearance()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
    
    func configureTabBarItems() {
        charactersVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        aboutVC.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
    }
}
