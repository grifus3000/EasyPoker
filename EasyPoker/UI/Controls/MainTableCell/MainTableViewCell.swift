//
//  MainTableViewCell.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 13.05.2022.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var playerPhoto: UIImageView!
    @IBOutlet private weak var playerName: UILabel!
    @IBOutlet private weak var playerChips: UILabel!
    @IBOutlet private weak var playerBet: UILabel!
    
    // MARK: - Static Properties
    
    static let cellId = "MainTableViewCell"
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Private Methods

    private func configureCell() {
        playerPhoto.layoutIfNeeded()
        playerPhoto.layer.cornerRadius = playerPhoto.bounds.height / 2
    }
    
    // MARK: - Public Methods
    
    func setup(with player: Player) {
        playerName.text = player.name
        playerChips.text = String(player.chips)
        playerBet.text = String(player.bet ?? 0)
    }
    
    func setup(bet isHidden: Bool) {
        playerBet.isHidden = isHidden
    }
}
