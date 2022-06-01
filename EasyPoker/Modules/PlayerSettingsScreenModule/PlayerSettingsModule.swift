//
//  PlayerSettingsModule.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 25.05.2022.
//

import Foundation
import UIKit

class PlayerSettingsModule {
    static func register() {
        Assembler.register(type: PlayerSettingsRouter.self) { viewController in
            return PlayerSettingsRouter(viewController: viewController)
        }
        
        Assembler.register(type: PlayerSettingsViewModel.self) { router in
            PlayerSettingsViewModel(router: router)
        }
    }
    
    static func setupViewController() -> PlayerSettingsViewController {
        let storyboard = UIStoryboard(name: "PlayerSetting", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayerSetting") as! PlayerSettingsViewController
        
        let router = Assembler.resolve(PlayerSettingsRouter.self, with: vc)
        vc.viewModel = Assembler.resolve(PlayerSettingsViewModel.self, with: router)
        
        return vc
    }
}
