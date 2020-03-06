//
//  MainTabBarViewController.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/4/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tb = MyTableViewController()
        let cb = MyCollectionViewController()
        let icon1 = UITabBarItem(title: "", image: UIImage(named: "tableIcon"), tag: 0)
        let icon2 = UITabBarItem(title: "", image: UIImage(named: "collectionIcon"), tag: 1)
        tb.tabBarItem = icon1
        cb.tabBarItem = icon2
        let controllers = [tb, cb]
        self.viewControllers = controllers
    }
}

