//
//  MainViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import UIKit

class MainViewController: UITabBarController {
    private let charactersVC = CharactersViewController(viewModel: CharactersViewModel())
    private let aboutVC = AboutViewController()
    private let strings = Strings.MainView.TabBarTitles.self
    
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
        charactersVC.tabBarItem = UITabBarItem(title: strings.characters, image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        aboutVC.tabBarItem = UITabBarItem(title: strings.about, image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
    }
}
