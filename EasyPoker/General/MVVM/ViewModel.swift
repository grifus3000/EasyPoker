//
//  ViewModel.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

class ViewModel<RouterType> {
    var router: RouterType?
    
    init(router: RouterType) {
        self.router = router
    }
}
