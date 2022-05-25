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
        let storyboard = UIStoryboard(name: "PlayerSetting", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayerSetting") as! PlayerSettingsViewController
        let router = PlayerSettingsRouter(viewController: vc)
        let viewModel = PlayerSettingsViewModel(router: router)
        vc.viewModel = viewModel
        
        Assembler.register(type: PlayerSettingsViewController.self, instance: vc)
    }
    
    static func setupViewController() -> PlayerSettingsViewController {
        let vc = Assembler.resolve(type: PlayerSettingsViewController.self)!
        return vc
    }
}
