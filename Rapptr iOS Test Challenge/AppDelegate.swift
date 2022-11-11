//
//  AppDelegate.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let menuVC = MenuViewController()
        
        let navigationController = UINavigationController(rootViewController: menuVC)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "header")
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "headerText") ?? .white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
    
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.rootViewController = navigationController
        
        return true
    }
}

