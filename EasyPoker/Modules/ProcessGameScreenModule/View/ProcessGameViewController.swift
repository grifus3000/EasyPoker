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
    @IBOutlet weak var betSlider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var playerChipsLabel: UILabel!
    @IBOutlet weak var bankAmountLabel: UILabel!
    
    private var playersTableView: MainTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            self?.setSliderChips(for: indexPath)
            self?.configureLabels()
        })
    }
    
    private func setSliderChips(for indexPath: IndexPath) {
        guard let chips = viewModel?.players?.value?[indexPath.row].chips else { return }
        betSlider.maximumValue = Float(chips)
    }
    
    private func configureLabels() {
        sliderValueLabel.text = String(Int(betSlider.value))
        let chips = betSlider.maximumValue
        playerChipsLabel.text = String(Int(chips))
        bankAmountLabel.text = String(viewModel?.bankAmount ?? 0)
        
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
    
    @IBAction func sliderDidChanged(_ sender: Any) {
        let roundedValue = round(betSlider.value)
        betSlider.value = roundedValue
        sliderValueLabel.text = String(Int(betSlider.value))
    }
}
