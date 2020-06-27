//
//  ListItem.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

enum ListItem: Equatable {
    case post(PostListItemViewModel)
    case comment(CommentListItemViewModel)
}
