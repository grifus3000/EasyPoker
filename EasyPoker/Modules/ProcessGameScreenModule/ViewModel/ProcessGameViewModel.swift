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
    var maximumBet: Int = 0
    private var isGameStart = true
    
    func startTheGame() {
        guard isGameStart else {
            isGameStart = false
            return
        }
        currentPlayerIndexPath.value = IndexPath(row: 0, section: 0)
    }
    
    func foldButtonDidTapped() {
        nextPlayer()
    }
    
    func checkButtonDidTapped() {
        nextPlayer()
    }
    
    func callButtonDidTapped() {
        nextPlayer()
    }
    
    func raiseButtonDidTapped() {
        nextPlayer()
    }
    
    private func nextPlayer() {
        guard var localRow = currentPlayerIndexPath.value?.row, let playersCount = players?.value?.count else { return }
        localRow += 1
        !(localRow <= playersCount - 1) ? localRow = 0 : nil
        currentPlayerIndexPath.value = IndexPath(row: localRow, section: 0)
    }
    
}
