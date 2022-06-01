//
//  Factory.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 28.05.2022.
//

import Foundation

class Factory<T, A> {
    var factory: (A) -> (T)
    
    init(factory: @escaping (A) -> (T)) {
        self.factory = factory
    }
}
