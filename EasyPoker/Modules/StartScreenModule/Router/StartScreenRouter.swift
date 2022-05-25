//
//  StartScreenRouter.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

class StartScreenRouter: Router, StartScreenRouting {
    func presentPlayerSettings() {
        let playerSettingsVC = PlayerSettingsModule.setupViewController()
        viewController?.show(playerSettingsVC, sender: nil)
    }
}
