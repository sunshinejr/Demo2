//
//  CommonState.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

enum CommonState {
    case loading
    case content([ListItem])
    case error(ErrorModel)
}

protocol CommonViewModeling {
    var state: CommonState { get }

    func refresh()
    func register(object: AnyObject, for updateCallback: Action)
}
