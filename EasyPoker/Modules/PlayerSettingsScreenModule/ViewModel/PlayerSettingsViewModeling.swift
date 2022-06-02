//
//  PlayerSettingsViewModeling.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 27.05.2022.
//

import Foundation

protocol PlayerSettingsViewModeling {
    var delegate: PlayerSettingsViewModelDelegate? { get set }
    func createPlayer(name: String?, chips: String?)
}
