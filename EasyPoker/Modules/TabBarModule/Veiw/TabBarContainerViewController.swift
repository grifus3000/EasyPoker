//
//  TabBarViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation
import UIKit

class TabBarContainerViewController: ViewController<TabBarContainerViewModeling> {
    
    weak var tabBarVC: TabBarViewController?
    
    func configureTabBar() {
        let storyboard = UIStoryboard(name: "TabBar", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
        tabBarVC = vc

        guard let tabBarVC = tabBarVC else {
            return
        }
        
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)
        
        tabBarVC.tabBar.backgroundColor = .gray
        tabBarVC.tabBar.alpha = 0.7
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
