//
//  ProcessGameViewModel.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 02.06.2022.
//

import Foundation

class ProcessGameViewModel: ViewModel<ProcessGameRouting>, ProcessGameViewModeling {
    var players: Observable<[Player]>?
    var currentPlayerIndexPath: Observable<IndexPath> = Observable(value: IndexPath(row: 0, section: 0))
    var currentBet: Int = 0
    var maximumBet: Int = 0
    var bankAmount: Int = 0
    var bets: Int = 0
    private var isGameStarted = false
    
    var currentPlayer: Player {
            guard let indexPath = currentPlayerIndexPath.value, let player = players?.value?[indexPath.row] else {
                fatalError("No player or index in ProcessGameViewModel array")
            }
            return player
    }
    
    func startTheGame() {
        guard !isGameStarted else {
            return
        }
        isGameStarted = true
        currentPlayerIndexPath.value = IndexPath(row: 0, section: 0)
    }
    
    func foldButtonDidTapped() {
        currentPlayer.setup(state: .fold)
        nextPlayer()
    }
    
    func checkButtonDidTapped() {
        nextPlayer()
    }
    
    func callButtonDidTapped() {
        callBet()
        currentPlayer.changeStateInGame(with: maximumBet)
        if isEndOfCircle() {
            endOfCircle()
        } else {
            nextPlayer()
        }
    }
    
    func raiseButtonDidTapped() {
        raiseBet()
        resetPlayersStateInGame(except: currentPlayer)
        if isEndOfCircle() {
            endOfCircle()
        } else {
            nextPlayer()
        }
    }
    
    private func callBet() {
        let minimumBetForCall = minimumBetForCall()
        if currentPlayer.chips - minimumBetForCall >= 0 {
            update(bet: minimumBetForCall)
        } else {
            update(bet: currentPlayer.chips)
        }
    }
    
    private func raiseBet() {
        update(bet: currentBet)
        currentPlayer.setup(state: .readyToContinue)
    }
    
    private func update(bet: Int) {
        bets += bet
        if currentPlayer.bet != nil {
            currentPlayer.bet! += bet
        } else {
            currentPlayer.bet = bet
        }
        currentPlayer.chips -= bet
        selectMaximumBet()
    }
    
    private func selectMaximumBet() {
        players?.value?.forEach({ player in
            if maximumBet < player.bet ?? 0 {
                maximumBet = player.bet ?? 0
            }
        })
    }
    
    private func minimumBetForCall() -> Int {
        maximumBet - (currentPlayer.bet ?? 0)
    }
    
    private func nextPlayer() {
        guard var localRow = currentPlayerIndexPath.value?.row, let playersCount = players?.value?.count else { return
        }
        localRow += 1
        !(localRow <= playersCount - 1) ? localRow = 0 : nil
        currentPlayerIndexPath.value = IndexPath(row: localRow, section: 0)
        
        if currentPlayer.state == .fold, currentPlayer.state == .inactive, currentPlayer.state == .readyToContinue {
            nextPlayer()
        }
    }
    
    private func isEndOfCircle() -> Bool {
//        var result = true
//        players?.value?.forEach({ player in
//            if player.bet != maximumBet {
//                result = false
//                return
//            }
//        })
//        return result
        var result = true
        players?.value?.forEach({ player in
            if player.state == .needToCall {
                result = false
                return
            }
        })
        return result
    }
    
    private func endOfCircle() {
        bankAmount += bets
        bets = 0
        maximumBet = 0
        currentPlayerIndexPath.value?.row = 0
        resetAllBets()
        resetPlayersStateInGame()
        
        switch currentPlayer.state {
        case .inactive, .fold, .readyToContinue:
            nextPlayer()
        case .needToCall:
            break
        }
    }
    
    private func resetAllBets() {
        players?.value?.forEach({ player in
            player.bet = 0
        })
    }
    
    private func resetPlayersStateInGame(except currentPlayer: Player? = nil) {
        players?.value?.forEach({ player in
            if player !== currentPlayer {
                player.resetStateInGame()
            }
        })
    }
}

extension ProcessGameViewModel {
    func winnerWasSelected(with indexPath: IndexPath) {
        let winner = players?.value?[indexPath.row]
        winner?.chips += bankAmount
        resetAllBets()
        currentPlayerIndexPath.value?.row = 0
    }
}
