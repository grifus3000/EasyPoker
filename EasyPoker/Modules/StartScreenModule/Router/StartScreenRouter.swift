//
//  StartScreenRouter.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

class StartScreenRouter: Router, StartScreenRouting {
    func presentPlayerSettings(delegate: PlayerSettingsViewModelDelegate) {
        let playerSettingsVC = PlayerSettingsModule.setupViewController()
        playerSettingsVC.viewModel?.delegate = delegate
        viewController?.show(playerSettingsVC, sender: nil)
    }
}
