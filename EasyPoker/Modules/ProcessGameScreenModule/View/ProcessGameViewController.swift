//
//  ProcessGameViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 02.06.2022.
//

import Foundation
import UIKit

class ProcessGameViewController: ViewController<ProcessGameViewModeling> {
    
    @IBOutlet weak var foldButton: EPButton!
    @IBOutlet weak var checkButton: EPButton!
    @IBOutlet weak var callButton: EPButton!
    @IBOutlet weak var raiseButton: EPButton!
    @IBOutlet weak var betSlited: UISlider!
    
    private var playersTableView: MainTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.startTheGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainTableView" {
            guard let tableView = segue.destination as? MainTableViewController else { return }
            playersTableView = tableView
        }
    }

    private func configureTable() {
        playersTableView?.setup(viewModel?.players)
    }
    
    private func configureObserver() {
        viewModel?.currentPlayerIndexPath.addObserver(closure: { [weak self] value in
            guard let indexPath = value else { return }
            self?.playersTableView?.selectCell(for: indexPath)
        })
    }
    
    @IBAction func foldButtonDidTapped(_ sender: Any) {
        viewModel?.foldButtonDidTapped()
    }
    
    @IBAction func checkButtonDidTapped(_ sender: Any) {
        viewModel?.checkButtonDidTapped()
    }
    
    @IBAction func callButtonDidTapped(_ sender: Any) {
        viewModel?.callButtonDidTapped()
    }
    
    @IBAction func raiseButtonDidTapped(_ sender: Any) {
        viewModel?.raiseButtonDidTapped()
    }
}
