//
//  MainTableViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 13.05.2022.
//

import UIKit

class MainTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var playersObservable: Observable<[Player]>?
    
    private var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    var players: [Player]? {
        guard let playersObservable = playersObservable else {
            return nil
        }
        return playersObservable.value
    }
    
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
        deselectCell(for: selectedIndex)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .black
        selectedIndex = indexPath
    }
    
    func deselectCell(for indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .clear
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
        cell.layer.cornerRadius = 20
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 2.5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
