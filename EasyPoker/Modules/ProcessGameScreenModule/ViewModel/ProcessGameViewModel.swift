//
//  ProcessGameViewModel.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 02.06.2022.
//

import Foundation

final class ProcessGameViewModel: ViewModel<ProcessGameRouting>, ProcessGameViewModeling {
    // MARK: - Private Properties
    
    private var isGameStarted = false
    
    private var isEndOfCircle: Bool {
        var result = true
        players?.value?.forEach({ player in
            if player.state == .needToCall {
                result = false
                return
            }
        })
        return result
    }
    
    private var minimumBetForCall: Int {
        maximumBet - (currentPlayer.bet ?? 0)
    }
    
    private var playerCanCall: Bool {
        return maximumBet != 0
    }
    
    private var playerCanCheck: Bool {
        return maximumBet == 0
    }
    
    private var playerCanRaise: Bool {
        return (currentBet + (currentPlayer.bet ?? 0)) > maximumBet
    }
    
    // MARK: - Public Properties
    
    var players: Observable<[Player]>?
    var currentPlayerIndexPath: Observable<IndexPath> = Observable(value: IndexPath(row: 0, section: 0))
    var currentBet: Int = 0
    var maximumBet: Int = 0
    var bankAmount: Int = 0
    var bets: Int = 0
    
    var currentPlayer: Player {
            guard let indexPath = currentPlayerIndexPath.value,
                  let player = players?.value?[indexPath.row] else {
                fatalError("No player or index in ProcessGameViewModel array")
            }
            return player
    }
    
    var foldButtonEnabled: Bool {
        return true
    }
    
    var callButtonColorEnabled: Bool {
        playerCanCall
    }
    
    var checkButtonColorEnabled: Bool {
        playerCanCheck
    }
    
    var raiseButtonColorEnabled: Bool {
        playerCanRaise
    }
    
    // MARK: - Public Methods
    
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
        if !playerCanCheck {
            return
        }
        
        nextPlayer()
    }
    
    func callButtonDidTapped() {
        if !playerCanCall {
            return
        }
        
        callBet()
        currentPlayer.changeStateInGame(with: maximumBet)
        if isEndOfCircle {
            endOfCircle()
        } else {
            nextPlayer()
        }
    }
    
    func raiseButtonDidTapped() {
        if !playerCanRaise {
            return
        }
        
        raiseBet()
        resetPlayersStateInGame(except: currentPlayer)
        if isEndOfCircle {
            endOfCircle()
        } else {
            nextPlayer()
        }
    }
    
    // MARK: Private methods
    
    private func callBet() {
        let minimumBetForCall = minimumBetForCall
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
    
    private func nextPlayer() {
        guard var localRow = currentPlayerIndexPath.value?.row,
              let playersCount = players?.value?.count else {
            return
        }

        localRow += 1
        !(localRow <= playersCount - 1) ? localRow = 0 : nil
        currentPlayerIndexPath.value = IndexPath(row: localRow, section: 0)
        
        if currentPlayer.state == .fold,
           currentPlayer.state == .inactive,
           currentPlayer.state == .readyToContinue {
            nextPlayer()
        }
    }
    
    private func endOfCircle() {
        bankAmount += bets
        bets = 0
        maximumBet = 0
        resetAllBets()
        currentPlayerIndexPath.value?.row = 0
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

extension ProcessGameViewModel: MainTableViewControllerDelegate {
    func winnerWasSelected(with indexPath: IndexPath) {
        let winner = players?.value?[indexPath.row]
        winner?.chips += bankAmount
        resetAllBets()
        currentPlayerIndexPath.value?.row = 0
        bankAmount = 0
    }
}
