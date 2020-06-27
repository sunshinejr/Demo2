//
//  ListItem.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

enum ListItem: Equatable {
    case post(id: String, title: String, body: String, author: String, more: ButtonAction)
    case comment(id: String, title: String, body: String, author: String)
}
