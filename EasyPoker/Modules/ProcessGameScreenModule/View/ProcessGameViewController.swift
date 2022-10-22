//
//  ProcessGameViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 02.06.2022.
//

import Foundation
import UIKit

final class ProcessGameViewController: ViewController<ProcessGameViewModeling> {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var foldButton: EPButton!
    @IBOutlet private weak var checkButton: EPButton!
    @IBOutlet private weak var callButton: EPButton!
    @IBOutlet private weak var raiseButton: EPButton!
    @IBOutlet private weak var finishTheRoundButton: EPButton!
    @IBOutlet private weak var betSlider: UISlider!
    @IBOutlet private weak var sliderValueLabel: UILabel!
    @IBOutlet private weak var playerChipsLabel: UILabel!
    @IBOutlet private weak var bankAmountLabel: UILabel!
    @IBOutlet private weak var betsAmountLabel: UILabel!
    
    // MARK: - Private Properties
    
    private var playersTableView: MainTableViewController?
    
    // MARK: - Lifecycle
    
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

    // MARK: - Private Methods
    
    private func configureButtons() {
        guard let viewModel = viewModel else { return }
        
        foldButton.tintColor = calculateButtonColor(isEnabled: viewModel.foldButtonEnabled)
        callButton.tintColor = calculateButtonColor(isEnabled: viewModel.callButtonColorEnabled)
        checkButton.tintColor = calculateButtonColor(isEnabled: viewModel.checkButtonColorEnabled)
        raiseButton.tintColor = calculateButtonColor(isEnabled: viewModel.raiseButtonColorEnabled)
    }
    
    private func calculateButtonColor(isEnabled: Bool) -> UIColor {
        if isEnabled {
            return .white
        } else {
            return .gray
        }
    }
    
    private func configureTable() {
        playersTableView?.setup(viewModel?.players)
        playersTableView?.delegate = viewModel as? any MainTableViewControllerDelegate
    }
    
    private func configureObservers() {
        viewModel?.currentPlayerIndexPath.addObserver(closure: { [weak self] value in
            guard let indexPath = value else { return }
            
            self?.playersTableView?.selectCell(for: indexPath)
            self?.setSliderChips(for: indexPath)
            self?.configureLabels()
            self?.configureButtons()
        })
        playersTableView?.observableState.addObserver(closure: { [weak self] value in
            switch value {
            case .displayingInformation:
                self?.finishTheRoundButton.setTitle("Finish the round")
                self?.configureLabels()
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
    
    // MARK: - IBActions
    
    @IBAction func foldButtonDidTapped(_ sender: Any) {
        viewModel?.foldButtonDidTapped()
        playersTableView?.reloadTable()
    }
    
    @IBAction func checkButtonDidTapped(_ sender: Any) {
        viewModel?.checkButtonDidTapped()
        playersTableView?.reloadTable()
    }
    
    @IBAction func callButtonDidTapped(_ sender: Any) {
        viewModel?.callButtonDidTapped()
        playersTableView?.reloadTable()
    }
    
    @IBAction func raiseButtonDidTapped(_ sender: Any) {
        viewModel?.raiseButtonDidTapped()
        playersTableView?.reloadTable()
    }
    
    @IBAction func sliderDidChanged(_ sender: Any) {
        let roundedValue = round(betSlider.value)
        betSlider.value = roundedValue
        let intSliderValue = Int(betSlider.value)
        sliderValueLabel.text = String(intSliderValue)
        viewModel?.currentBet = intSliderValue
        raiseButton.tintColor = calculateButtonColor(isEnabled: viewModel?.raiseButtonColorEnabled ?? false)
    }
    
    @IBAction func finishTheRoundButton(_ sender: Any) {
        playersTableView?.state = .choosingTheWinner
    }
}
