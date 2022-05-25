//
//  PlayerSettingsViewController.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 25.05.2022.
//

import Foundation
import UIKit

class PlayerSettingsViewController: ViewController<PlayerSettingsViewModel> {
    
    @IBOutlet weak var playerAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerAvatar.layer.cornerRadius = playerAvatar.bounds.height / 2
    }
}
