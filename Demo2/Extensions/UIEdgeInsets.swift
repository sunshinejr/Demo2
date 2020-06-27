//
//  UIEdgeInsets.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    static func all(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }

    static func only(top: CGFloat = 0.0, left: CGFloat = 0.0, bottom: CGFloat = 0.0, right: CGFloat = 0.0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
