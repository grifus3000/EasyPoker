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
        let combinationsVC = CombinationsModule.setupViewController()
        
        let image1 = UIImage(named: "GameIcon")
        let item1 = UITabBarItem(title: "Game", image: image1, selectedImage: nil)
        item1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Itim-Regular", size: 20)], for: .normal)
        
        let tabBarHeight = vc.tabBarVC?.tabBar.bounds.height
        let itemOffset = (tabBarHeight ?? 0) / 5
        
        item1.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: itemOffset)
        item1.imageInsets = UIEdgeInsets(top: itemOffset, left: 0, bottom: -itemOffset, right: 0)
        
        startVC.tabBarItem = item1
        vc.tabBarVC?.tabBar.tintColor = .black
        
        let image2 = UIImage(named: "CombinationsIcon")
        let item2 = UITabBarItem(title: "Combinations", image: image2, selectedImage: nil)
        item2.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Itim-Regular", size: 20)], for: .normal)
        combinationsVC.tabBarItem = item2
        
        vc.tabBarVC!.viewControllers = [
            startVC,
            combinationsVC
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

