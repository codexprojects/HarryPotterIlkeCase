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
    var appCoordinator: ApplicationFlowCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Load main view controller without storyboard.
        let window =  UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = ApplicationFlowCoordinator(window: window, dependencyProvider: ApplicationComponentsFactory())
        self.appCoordinator.start()

        self.window = window
        self.window?.makeKeyAndVisible()

        return true
    }

}
