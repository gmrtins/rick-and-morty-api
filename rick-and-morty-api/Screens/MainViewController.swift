//
//  MainViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import UIKit

class MainViewController: UITabBarController {
    let caractersVC = CaractersViewController()
    let aboutVC = AboutViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUITabBarItems()
        configureTabBar()
    }
    
    func configureUITabBarItems() {
        caractersVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        aboutVC.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
    }
    
    func configureTabBar() {
        tabBar.tintColor = UIColor(hex: "#FF1493")
        
        tabBar.barTintColor = .gray
        setViewControllers([caractersVC, aboutVC], animated: true)
        let appearance = UITabBarAppearance()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
}
