//
//  Action.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation
import UIKit

@dynamicCallable
final class Action: Equatable {
    let id: String
    let action: (() -> Void)?

    init(id: String = UUID().uuidString, action: (() -> Void)?) {
        self.id = id
        self.action = action
    }

    func dynamicallyCall(withArguments: [String]) {
        action?()
    }

    static func == (lhs: Action, rhs: Action) -> Bool {
        return lhs.id == rhs.id
    }
}

@dynamicCallable
final class AlertAction: Equatable {
    let name: String
    #warning("TODO: This should be platform-independent")
    let style: UIAlertAction.Style
    let action: (() -> Void)?

    init(name: String, style: UIAlertAction.Style, action: (() -> Void)?) {
        self.name = name
        self.style = style
        self.action = action
    }

    func dynamicallyCall(withArguments: [String]) {
        action?()
    }

    static func == (lhs: AlertAction, rhs: AlertAction) -> Bool {
        return lhs.name == rhs.name
    }
}

@dynamicCallable
final class ButtonAction: Equatable {
    let name: String
    let action: (() -> Void)?

    init(name: String, action: (() -> Void)?) {
        self.name = name
        self.action = action
    }

    func dynamicallyCall(withArguments: [String]) {
        action?()
    }

    static func == (lhs: ButtonAction, rhs: ButtonAction) -> Bool {
        return lhs.name == rhs.name
    }
}
