//
//  UserDefault.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
@propertyWrapper
struct UserDefault<Value> {
    private let name: String
    private let defaultValue: Value
    init(_ name: String, defaultValue: Value) {
        self.name = name
        self.defaultValue = defaultValue
    }
    var wrappedValue: Value {
        set {
            UserDefaults.standard.setValue(newValue, forKey: name)
        }
        get {
            guard let result = UserDefaults.standard.object(forKey: name) as? Value else { return defaultValue }
            return result
        }
    }
}
