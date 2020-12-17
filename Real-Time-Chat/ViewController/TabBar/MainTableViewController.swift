//
//  MainTableViewController.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/17.
//

import UIKit

class MainTableViewController: UITabBarController {

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        
        
    }
    //MARK: - UI method
    private func setupTabBar() {
        let firstVC = ChatViewController()
        let firstViewController = UINavigationController(rootViewController: firstVC)
        firstViewController.tabBarItem = UITabBarItem(title: "Chat", image: nil, tag: 0)
        
        let secondVC = ProfileViewController()
        let secondViewController = UINavigationController(rootViewController: secondVC)
        secondViewController.tabBarItem = UITabBarItem(title: "Setting", image: nil, tag: 1)
        
        
        let tabBarList = [firstViewController, secondViewController]
        self.viewControllers = tabBarList
    }
}
