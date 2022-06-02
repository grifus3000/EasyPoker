//
//  StartScreenVeiwModel.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

class StartScreenViewModel: ViewModel<StartScreenRouting>, StartScreenViewModeling {
    
    var completion: ((_ player: Player) -> ())?
    
    func showPlayerSettings() {
        router?.presentPlayerSettings(delegate: self)
    }
    
    func presentGameProcess() {
        router?.presentGameProcess()
    }
}

extension StartScreenViewModel: PlayerSettingsViewModelDelegate {
    func sendPlayer(_ player: Player) {
        completion!(player)
    }
}
