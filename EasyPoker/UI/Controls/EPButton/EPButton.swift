//
//  EPButton.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 13.05.2022.
//

import UIKit

class EPButton: UIButton {

    let customTitle: String = "Finish the round"
    
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
        
        self.configuration = config
        setTitle(titleLabel?.text ?? "")
    }
    
    func setTitle(_ title: String) {
        let container = AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Itim-Regular", size: 24)])
        let localTitle = AttributedString(title, attributes: container)
        
        configuration?.attributedTitle = localTitle
    }
    
}
