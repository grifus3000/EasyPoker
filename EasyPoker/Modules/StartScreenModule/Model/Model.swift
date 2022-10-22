//
//  Model.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 27.05.2022.
//

import Foundation

enum PlayerState {
    case inactive
    case fold
    case needToCall
    case readyToContinue
}

class Player {
    init(name: String, chips: Int, bet: Int? = nil) {
        self.name = name
        self.chips = chips
        self.bet = bet
    }
    
    var name: String
    var chips: Int
    var bet: Int?
    
    private(set) var state: PlayerState = .needToCall
    
    func changeStateInGame(with maxBet: Int) {
        guard state != .inactive,
              state != .fold,
              state != .readyToContinue else {
            return
        }
        
        switch state {
        case .needToCall:
            state = .readyToContinue
        case .readyToContinue:
            state = .needToCall
        case .inactive, .fold:
            break
        }
    }
    
    func resetStateInGame() {
        guard state != .inactive,
              state != .fold,
              chips != 0 else {
            return
        }
        
        state = .needToCall
    }
    
    func resetStateByNewRound() {
        guard state != .inactive, chips != 0 else {
            state = .inactive
            return
        }
        state = .needToCall
    }
    
    func setup(state: PlayerState) {
        self.state = state
    }
}
