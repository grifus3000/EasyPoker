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

    func configureCell() {
        playerPhoto.layer.cornerRadius = playerPhoto.bounds.height / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
