//
//  StartScreenModule.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation
import UIKit

class StartScreenModule {
    static func register() {
        let storyboard = UIStoryboard(name: "StartScreen", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "StartScreen") as! StartScreenViewController
        let router = StartScreenRouter(viewController: vc)
        let viewModel = StartScreenViewModel(router: router)
        vc.viewModel = viewModel
        
        Assembler.register(type: StartScreenViewController.self, instance: vc)
        Assembler.register(type: StartScreenRouter.self, instance: router)
        Assembler.register(type: StartScreenViewModel.self, instance: viewModel)
    }
    
    static func setupViewController() -> StartScreenViewController {
        
        let viewController = Assembler.resolve(type: StartScreenViewController.self)!
        
        
        return viewController
    }
    
}
