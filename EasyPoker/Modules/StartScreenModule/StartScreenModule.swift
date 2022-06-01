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
        Assembler.register(type: StartScreenRouter.self, closure: { viewController in
            StartScreenRouter(viewController: viewController)
        })
        
        Assembler.register(type: StartScreenViewModel.self) { router in
            StartScreenViewModel(router: router)
        }
    }
    
    static func setupViewController() -> StartScreenViewController {
        
        let storyboard = UIStoryboard(name: "StartScreen", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "StartScreen") as! StartScreenViewController
        
        let router = Assembler.resolve(StartScreenRouter.self, with: vc)
        vc.viewModel = Assembler.resolve(StartScreenViewModel.self, with: router)
        
        return vc
    }
    
}
