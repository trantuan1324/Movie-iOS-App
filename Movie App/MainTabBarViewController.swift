//
//  ViewController.swift
//  Movie App
//
//  Created by Trần Quang Tuấn on 2/8/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.tabBarItem.title = "Home"
        
        let upComingVC = UINavigationController(rootViewController: UpComingViewController())
        upComingVC.tabBarItem.image = UIImage(systemName: "play")
        upComingVC.tabBarItem.title = "Coming soon"
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchVC.tabBarItem.title = "Search"
        
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        downloadVC.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        downloadVC.tabBarItem.title = "Downloads"
        
        setViewControllers([homeVC, upComingVC, searchVC, downloadVC], animated: true)
        tabBar.tintColor = .label
    }


}

