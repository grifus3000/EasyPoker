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
        let storyboard = UIStoryboard(name: "Combinations", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "Combinations") as! CombinationsViewController
        let router = CombinationsRouter(viewController: vc)
        let viewModel = CobinationsViewModel(router: router)
        vc.viewModel = viewModel
        
        Assembler.register(type: CombinationsViewController.self, instance: vc)
    }
    
    static func setupViewContoller() -> CombinationsViewController {
        let vc = Assembler.resolve(type: CombinationsViewController.self)!
        return vc
    }
}
