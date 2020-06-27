//
//  ViewModeling.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

protocol ViewModeling {
    func register(object: AnyObject, for updateCallback: Action)
}
