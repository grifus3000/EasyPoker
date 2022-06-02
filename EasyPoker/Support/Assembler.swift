//
//  Assembler.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

class Assembler {
    
    static private var factories: [Int: AnyObject] = [:]
    
    static func register<T>(type: T.Type, closure: @escaping () -> T ) {
        let hash = ObjectIdentifier(type).hashValue
        Assembler.factories[hash] = Factory(factory: closure) as AnyObject
    }
    
    static func register<T, A>(type: T.Type, closure: @escaping (A) -> T ) {
        let hash = ObjectIdentifier(type).hashValue
        let wrapper: (AnyObject) -> T = { any in
            guard let arg = any as? A else {
                fatalError()
            }
            return closure(arg)
        }
        Assembler.factories[hash] = Factory(factory: wrapper) as AnyObject
    }
    
    static func resolve<T>(type: T.Type) -> T {
        let hash = ObjectIdentifier(type).hashValue
        guard let factory = Assembler.factories[hash] as? Factory<T, Void> else {
            fatalError()
        }
        return factory.factory(())
    }
    
    static func resolve<T, A>(_ type: T.Type, with arg: A) -> T {
        let hash = ObjectIdentifier(type).hashValue
        guard let factory = factories[hash] as? Factory<T, AnyObject> else {
            fatalError()
        }
        return factory.factory(arg as AnyObject)
    }
    
}

extension Assembler {
    static func registerModules() {
        TabBarContainerModule.register()
        StartScreenModule.register()
        CombinationsModule.register()
        PlayerSettingsModule.register()
        ProcessGameModule.register()
    }
}
