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
        let router = StartScreenRouter()
        let viewModel = StartScreenViewModel()
        
        Assembler.register(type: StartScreenRouter.self, instance: router)
        Assembler.register(type: StartScreenViewModel.self, instance: viewModel)
    }
    
    static func setupViewController() -> StartScreenViewController {
        let storyboard = UIStoryboard(name: "StartScreen", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StartScreen") as! StartScreenViewController
        
        let viewModel = Assembler.resolve(type: StartScreenViewModeling.self)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
}
