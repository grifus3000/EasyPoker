//
//  StartScreenViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation
import UIKit

class StartScreenViewController: ViewController<StartScreenViewModeling> {
    
    private var playersTableView: MainTableViewController?
    
    @IBAction func addPlayerButton(_ sender: Any) {
        viewModel?.showPlayerSettings()
    }
    
    override func viewDidLoad() {
        viewModel?.completion = { [weak self] player in
            self?.playersTableView?.append(player: player)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainTableView" {
            guard let tableView = segue.destination as? MainTableViewController else { return }
            playersTableView = tableView
        }
    }
    
    
}
