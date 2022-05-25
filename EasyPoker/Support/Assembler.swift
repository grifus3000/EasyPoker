//
//  Assembler.swift
//  EasyPoker
//
//  Created by Фирсов Алексей on 12.05.2022.
//

import Foundation

class Assembler {
    
    static var modules = [Int: AnyObject]()
    
    static func register<T>(type: T.Type, instance: AnyObject) {
        let hash = ObjectIdentifier(type).hashValue
        Assembler.modules[hash] = instance
    }
    
    static func resolve<T>(type: T.Type) -> T? {
        let hash = ObjectIdentifier(type).hashValue
        return Assembler.modules[hash] as? T
    }
    
}

extension Assembler {
    static func registerModules() {
        TabBarContainerModule.register()
        StartScreenModule.register()
        CombinationsModule.register()
        PlayerSettingsModule.register()
    }
}
