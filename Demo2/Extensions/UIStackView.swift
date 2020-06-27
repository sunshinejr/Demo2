//
//  UIStackView.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

public extension UIStackView {
    func force(backgroundColor: UIColor) {
        use(background: .colored(backgroundColor))
    }

    func use(background: UIView) {
        background.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(background, at: 0)
        background.pin(to: self)
    }
}
