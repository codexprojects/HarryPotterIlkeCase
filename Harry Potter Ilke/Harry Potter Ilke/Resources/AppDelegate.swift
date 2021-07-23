//
//  AppDelegate.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 22.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Load main view controller without storyboard.
        loadMainViewController()
        
        return true
    }

}

extension AppDelegate {
    
    private func loadMainViewController() {
        navController = UINavigationController()
        let productListViewController: ProductListViewController = ProductListViewController()
        self.navController!.pushViewController(productListViewController, animated: false)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navController
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
    }
}
