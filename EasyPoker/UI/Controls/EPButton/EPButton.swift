//
//  EPButton.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 13.05.2022.
//

import UIKit

class EPButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureButton()
    }
    
    func configureButton() {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .black
        config.background.cornerRadius = 20
        
        let container = AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Itim-Regular", size: 24)])
        let title = AttributedString(titleLabel?.text ?? "", attributes: container)
        
        config.attributedTitle = title
        
        self.configuration = config
    }
    
}
