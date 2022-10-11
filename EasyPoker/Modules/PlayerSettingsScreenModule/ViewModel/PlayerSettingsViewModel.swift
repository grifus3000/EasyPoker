//
//  PlayerSettingsViewModel.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 25.05.2022.
//

import Foundation

protocol PlayerSettingsViewModelDelegate: AnyObject {
    func sendPlayer(_ player: Player)
}

final class PlayerSettingsViewModel: ViewModel<PlayerSettingsRouting>, PlayerSettingsViewModeling {
    // MARK: - Public Properties
    
    weak var delegate: PlayerSettingsViewModelDelegate?
    
    // MARK: - Public Methods
    
    func createPlayer(name: String?, chips: String?) {
        guard let name = name, let chips = chips else {
            return
        }
        
        guard let chipsInt = Int(chips) else {
            return
        }
        let player = Player(name: name, chips: chipsInt)
        
        delegate?.sendPlayer(player)
    }
}
