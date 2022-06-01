//
//  TabBarModule.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation
import UIKit

class TabBarContainerModule {
    static func register() {
        Assembler.register(type: TabBarContainerRouter.self, closure: {
            return TabBarContainerRouter()
        })
                           
        Assembler.register(type: TabBarContainerViewModel.self, closure: {
            TabBarContainerViewModel()
        })
    }
    
    static func setupViewController() -> TabBarContainerViewController {
        let storyboard = UIStoryboard(name: "TabBarContainer", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarContainer") as! TabBarContainerViewController
        
        viewController.viewModel = Assembler.resolve(type: TabBarContainerViewModel.self)
        
        return viewController
    }
}
