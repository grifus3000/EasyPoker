//
//  CombinationsModule.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 13.05.2022.
//

import Foundation
import UIKit

class CombinationsModule {
    
    static func register() {
        Assembler.register(type: CombinationsRouter.self) { viewController in
            return CombinationsRouter(viewController: viewController)
        }
        
        Assembler.register(type: CombinationsViewModel.self) { router in
            return CombinationsViewModel(router: router)
        }
    }
    
    static func setupViewController() -> CombinationsViewController {
        let storyboard = UIStoryboard(name: "Combinations", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "Combinations") as! CombinationsViewController
        
        let router = Assembler.resolve(CombinationsRouter.self, with: vc)
        vc.viewModel = Assembler.resolve(CombinationsViewModel.self, with: router)
        
        return vc
    }
}
