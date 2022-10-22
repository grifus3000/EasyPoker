//
//  ProcessGameViewModeling.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 02.06.2022.
//

import Foundation

protocol ProcessGameViewModeling {
    var players: Observable<[Player]>? { get set }
    var currentPlayerIndexPath: Observable<IndexPath> { get set }
    var currentBet: Int { get set }
    var bankAmount: Int { get set }
    var maximumBet: Int { get set }
    var bets: Int { get set }
    var currentPlayer: Player { get }
    
    var foldButtonEnabled: Bool { get }
    var callButtonColorEnabled: Bool { get }
    var checkButtonColorEnabled: Bool { get }
    var raiseButtonColorEnabled: Bool { get }
    
    func foldButtonDidTapped()
    func checkButtonDidTapped()
    func callButtonDidTapped()
    func raiseButtonDidTapped()
    func startTheGame()
}
