//
//  Observable.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 06.06.2022.
//

import Foundation

class Observable<T> {
    var value: T? = nil {
        didSet {
            observers.forEach { closure in
                closure(value)
            }
        }
    }
    
    private var observers: [(_ value: T?) -> ()] = []

    init(value: T) {
        self.value = value
    }
    
    func addObserver(closure: @escaping (_ value: T?) -> ()) {
        observers.append(closure)
    }
}
