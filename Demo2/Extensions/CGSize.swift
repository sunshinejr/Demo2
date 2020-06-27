//
//  CGSize.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import CoreGraphics

extension CGSize {
    static func size(_ size: CGFloat) -> CGSize {
        return CGSize(width: size, height: size)
    }
}
