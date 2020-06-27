//
//  Delayed.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

@propertyWrapper
struct Delayed<Value> {
    private var _value: Value?

    var wrappedValue: Value {
        get {
            guard let value = _value else {
                fatalError("Property accessed before being initialized.")
            }
            return value
        }
        set {
            _value = newValue
        }
    }

    init() {}
}
