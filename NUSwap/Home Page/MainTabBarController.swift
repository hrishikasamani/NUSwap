//
//  MainTabBarController.swift
//  NUSwap
//
//  Created by Preksha Patil on 04/11/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Initialize HomePageViewController and embed it in a UINavigationController
        let homeVC = HomePageViewController()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let homeNavController = UINavigationController(rootViewController: homeVC)

        // Initialize BiddingsViewController and embed it in a UINavigationController
        let biddingsVC = BiddingsViewController()
        biddingsVC.title = "Biddings"
        biddingsVC.tabBarItem = UITabBarItem(title: "Biddings", image: UIImage(systemName: "list.bullet"), tag: 1)
        let biddingsNavController = UINavigationController(rootViewController: biddingsVC)

        // Initialize ListingsViewController and embed it in a UINavigationController
        let listingsVC = ListingsViewController()
        listingsVC.title = "Listings"
        listingsVC.tabBarItem = UITabBarItem(title: "Listings", image: UIImage(systemName: "tag"), tag: 2)
        let listingsNavController = UINavigationController(rootViewController: listingsVC)

        // Initialize ProfileViewController and embed it in a UINavigationController
        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        let profileNavController = UINavigationController(rootViewController: profileVC)

        // Set the viewControllers property to the navigation controllers
        self.viewControllers = [homeNavController, biddingsNavController, listingsNavController, profileNavController]
        
        UITabBar.appearance().tintColor = UIColor.systemRed
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
}
