//
//  AppDelegate.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Assembler.registerModules()
        
        configureWindow()
        
        let vc = TabBarContainerModule.setupViewController()
        vc.configureTabBar()
        
        let startVC = StartScreenModule.setupViewController()
        
        let item1 = UITabBarItem(title: "ni", image: nil, selectedImage: nil)
        startVC.tabBarItem = item1
        
        vc.tabBarVC!.viewControllers = [
            startVC
        ]
        
        window?.rootViewController = vc
        
        return true
    }
    
    func configureWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
    }

}

