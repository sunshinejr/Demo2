//
//  ListState.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

enum ListState: Equatable {
    case loading
    case content([ListItem])
    case error(ErrorModel)
}

protocol ListViewModeling: ViewModeling {
    var title: String { get }
    var state: ListState { get }

    func refresh()
}
