//
//  MainTableViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 13.05.2022.
//

import UIKit

protocol MainTableViewControllerDelegate: AnyObject {
    func winnerWasSelected(with indexPath: IndexPath)
}

class MainTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var playersObservable: Observable<[Player]>?
    private var selectedIndexPath: IndexPath?
    
    var observableState: Observable<TableState> = Observable(value: .displayingInformation)
    var state: TableState {
        get {
            return observableState.value ?? .displayingInformation
        }
        set {
            observableState.value = newValue
        }
    }
    var isBetHidden = true
    
    var players: [Player]? {
        guard let playersObservable = playersObservable else {
            return nil
        }
        return playersObservable.value
    }
    
    weak var delegate: MainTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: MainTableViewCell.cellId, bundle: nil), forCellReuseIdentifier: MainTableViewCell.cellId)
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setup(_ playersObservable: Observable<[Player]>?) {
        self.playersObservable = playersObservable
    }
    
    func selectCell(for indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let players = players else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
        cell.setup(with: players[indexPath.row])
        cell.setup(bet: isBetHidden)
        
        cell.layer.cornerRadius = 20
        if let selectedIndexPath = selectedIndexPath, selectedIndexPath == indexPath {
            cell.backgroundColor = .black
        } else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 2.5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .displayingInformation:
            tableView.deselectRow(at: indexPath, animated: false)
        case .choosingTheWinner:
            state = .displayingInformation
            delegate?.winnerWasSelected(with: indexPath)
            tableView.deselectRow(at: indexPath, animated: false)
        }
        
    }
}
