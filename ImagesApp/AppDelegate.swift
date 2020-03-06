//
//  AppDelegate.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/4/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit
    
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkManager.shared.getData { (photoAlbums) in
            if photoAlbums.count > 0 {
                SavedData.shared.photoAlbums = photoAlbums
                NotificationCenter.default.post(name: .getDataFinished, object: nil)
            }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let controller = MainTabBarViewController()
        let navigationVC = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationVC
        return true
    }
}
