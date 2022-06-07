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
        viewController?.navigationController?.present(playerSettingsVC, animated: true)
    }
    
    func presentGameProcess(players: Observable<[Player]>) {
        let gameProcessVC = ProcessGameModule.setupViewController()
        gameProcessVC.viewModel?.players = players
        viewController?.navigationController?.pushViewController(gameProcessVC, animated: true)
    }
}
