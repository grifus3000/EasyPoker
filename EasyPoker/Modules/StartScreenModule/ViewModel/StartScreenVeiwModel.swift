//
//  StartScreenVeiwModel.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

class StartScreenViewModel: ViewModel<StartScreenRouting>, StartScreenViewModeling {
    
    var players: Observable<[Player]> = Observable(value: [Player(name: "ONE", chips: 12), Player(name: "TWO", chips: 213), Player(name: "Three", chips: 1000)])
    
    func showPlayerSettings() {
        router?.presentPlayerSettings(delegate: self)
    }
    
    func presentGameProcess() {
        router?.presentGameProcess(players: players)
    }
}

extension StartScreenViewModel: PlayerSettingsViewModelDelegate {
    func sendPlayer(_ player: Player) {
        players.value?.append(player)
    }
}
