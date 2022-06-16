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
    @IBOutlet weak var finishTheRoundButton: EPButton!
    @IBOutlet weak var betSlider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var playerChipsLabel: UILabel!
    @IBOutlet weak var bankAmountLabel: UILabel!
    @IBOutlet weak var betsAmountLabel: UILabel!
    
    private var playersTableView: MainTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureObservers()
        viewModel?.startTheGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainTableView" {
            guard let tableView = segue.destination as? MainTableViewController else { return }
            tableView.isBetHidden = false
            playersTableView = tableView
        }
    }

    private func configureTable() {
        playersTableView?.setup(viewModel?.players)
        playersTableView?.delegate = viewModel
    }
    
    private func configureObservers() {
        viewModel?.currentPlayerIndexPath.addObserver(closure: { [weak self] value in
            guard let indexPath = value else { return }
            self?.playersTableView?.selectCell(for: indexPath)
            self?.setSliderChips(for: indexPath)
            self?.configureLabels()
        })
        playersTableView?.observableState.addObserver(closure: { [weak self] value in
            switch value {
            case .displayingInformation:
                self?.finishTheRoundButton.setTitle("Finish the round")
            case .choosingTheWinner:
                self?.finishTheRoundButton.setTitle("Choose the winner")
            case .none:
                return
            }
        })
    }
    
    private func setSliderChips(for indexPath: IndexPath) {
        guard let chips = viewModel?.currentPlayer.chips else { return }
        betSlider.maximumValue = Float(chips)
        betSlider.value = 0.0
        viewModel?.currentBet = 0
    }
    
    private func configureLabels() {
        sliderValueLabel.text = String(Int(betSlider.value))
        let chips = betSlider.maximumValue
        playerChipsLabel.text = String(Int(chips))
        bankAmountLabel.text = String(viewModel?.bankAmount ?? 0)
        betsAmountLabel.text = String(viewModel?.bets ?? 0)
    }
    
    @IBAction func foldButtonDidTapped(_ sender: Any) {
        viewModel?.foldButtonDidTapped()
        playersTableView?.tableView.reloadData()
    }
    
    @IBAction func checkButtonDidTapped(_ sender: Any) {
        viewModel?.checkButtonDidTapped()
        playersTableView?.tableView.reloadData()
    }
    
    @IBAction func callButtonDidTapped(_ sender: Any) {
        viewModel?.callButtonDidTapped()
        playersTableView?.tableView.reloadData()
    }
    
    @IBAction func raiseButtonDidTapped(_ sender: Any) {
        viewModel?.raiseButtonDidTapped()
        playersTableView?.tableView.reloadData()
    }
    
    @IBAction func sliderDidChanged(_ sender: Any) {
        let roundedValue = round(betSlider.value)
        betSlider.value = roundedValue
        let intSliderValue = Int(betSlider.value)
        sliderValueLabel.text = String(intSliderValue)
        viewModel?.currentBet = intSliderValue
    }
    
    @IBAction func finishTheRoundButton(_ sender: Any) {
        playersTableView?.state = .choosingTheWinner
    }
}
