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
        let router = TabBarContainerRouter()
        let viewModel = TabBarContainerViewModel()
        
        Assembler.register(type: TabBarContainerRouter.self, instance: router)
        Assembler.register(type: TabBarContainerViewModel.self, instance: viewModel)
    }
    
    static func setupViewController() -> TabBarContainerViewController {
        let storyboard = UIStoryboard(name: "TabBarContainer", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarContainer") as! TabBarContainerViewController
        
        let viewModel = Assembler.resolve(type: TabBarContainerViewModel.self)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
