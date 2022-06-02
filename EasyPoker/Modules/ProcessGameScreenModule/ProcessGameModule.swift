//
//  ProcessGameModule.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 02.06.2022.
//

import Foundation
import UIKit

class ProcessGameModule {
    static func register() {
        Assembler.register(type: ProcessGameRouter.self) { viewController in
            ProcessGameRouter(viewController: viewController)
        }
        
        Assembler.register(type: ProcessGameViewModel.self) { router in
            ProcessGameViewModel(router: router)
        }
    }
    
    static func setupViewController() -> ProcessGameViewController {
        let storyboard = UIStoryboard(name: "ProcessScreen", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProcessGame") as! ProcessGameViewController
        
        let router = Assembler.resolve(ProcessGameRouter.self, with: vc)
        vc.viewModel = Assembler.resolve(ProcessGameViewModel.self, with: router)
        
        return vc
    }
}
