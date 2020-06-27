//
//  ListItem.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

enum ListItem: Equatable {
    case post(PostViewModel)
    case comment(id: String, title: String, body: String, author: String, tapAction: (() -> Void)?)

    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        switch (lhs, rhs) {
        case let (.post(post1), .post(post2)):
            return post1 == post2
        case let (.comment(id1, title1, body1, more1, _), .comment(id2, title2, body2, more2, _)):
            return id1 == id2 && title1 == title2 && body1 == body2 && more1 == more2
        default:
            return false
        }
    }
}
