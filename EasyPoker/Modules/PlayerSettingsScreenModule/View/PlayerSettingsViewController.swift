//
//  PlayerSettingsViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 25.05.2022.
//

import Foundation
import UIKit

class PlayerSettingsViewController: ViewController<PlayerSettingsViewModeling> {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var playerNameLable: UITextField!
    @IBOutlet private weak var playerChipsLable: UITextField!
    @IBOutlet private weak var playerAvatar: UIImageView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerAvatar.layer.cornerRadius = playerAvatar.bounds.height / 2
    }
    
    // MARK: IBActions
    
    @IBAction func createButton(_ sender: Any) {
        viewModel?.createPlayer(name: playerNameLable.text, chips: playerChipsLable.text)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
