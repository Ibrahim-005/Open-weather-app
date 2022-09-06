//
//  AppDelegate.swift
//  Open weather app
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        let controller = HomeViewController()
        let nav = UINavigationController(rootViewController: controller)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

}

