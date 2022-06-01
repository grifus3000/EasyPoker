//
//  PlayerSettingsViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 25.05.2022.
//

import Foundation
import UIKit

class PlayerSettingsViewController: ViewController<PlayerSettingsViewModel> {
    
    @IBOutlet weak var playerNameLable: UITextField!
    @IBOutlet weak var playerChipsLable: UITextField!
    @IBOutlet weak var playerAvatar: UIImageView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerAvatar.layer.cornerRadius = playerAvatar.bounds.height / 2
    }
    
    // MARK: Logic
    
    @IBAction func createButton(_ sender: Any) {
        viewModel?.createPlayer(name: playerNameLable.text, chips: playerChipsLable.text)
        dismiss(animated: true)
    }
    
    
}
