//
//  Comment.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
