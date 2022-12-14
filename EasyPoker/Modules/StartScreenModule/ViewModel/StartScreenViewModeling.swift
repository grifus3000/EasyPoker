//
//  StartScreenViewModeling.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

protocol StartScreenViewModeling {
    var players: Observable<[Player]> { get set }
    
    func showPlayerSettings()
    func presentGameProcess()
}
