//
//  UIAlertController.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func error(_ model: ErrorModel) -> UIAlertController {
        let controller = UIAlertController(title: model.title, message: model.description, preferredStyle: .alert)
        let actions = model.actions.map(build(action:))
        actions.forEach(controller.addAction)

        return controller
    }

    private static func build(action: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: action.name, style: action.style, handler: { _ in action.action?() })
    }
}
