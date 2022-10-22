//
//  StartScreenViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation
import UIKit

final class StartScreenViewController: ViewController<StartScreenViewModeling> {
    // MARK: - Private Properties
    
    private var playersTableView: MainTableViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureTableData()
        configureObserver()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainTableView" {
            guard let tableView = segue.destination as? MainTableViewController else { return }
            playersTableView = tableView
        }
    }
    
    // MARK: - Private Methods
    
    private func configureTableData() {
        guard let viewModel = viewModel else { return }
        playersTableView?.setup(viewModel.players)
    }
    
    private func configureObserver() {
        guard let viewModel = viewModel else { return }
        viewModel.players.addObserver(closure: { value in
            self.playersTableView?.reloadTable()
        })
    }
    
    // MARK: - IBActions
    
    @IBAction private func addPlayerButton(_ sender: Any) {
        viewModel?.showPlayerSettings()
        playersTableView?.reloadTable()
    }
    
    @IBAction func startGameButton(_ sender: Any) {
        viewModel?.presentGameProcess()
    }
    
}
