//
//  MainTableViewCell.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 13.05.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let cellId = "MainTableViewCell"
    
    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerChips: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCell()
    }
    
    func configureCell() {
        playerPhoto.layoutIfNeeded()
        playerPhoto.layer.cornerRadius = playerPhoto.bounds.height / 2
    }
    
    func setup(with player: Player) {
        playerName.text = player.name
        playerChips.text = String(player.chips)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
