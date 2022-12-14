//
//  StartScreenRouting.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

protocol StartScreenRouting: Router {
    func presentPlayerSettings(delegate: PlayerSettingsViewModelDelegate)
    func presentGameProcess(players: Observable<[Player]>)
}
