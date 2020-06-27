//
//  Environment.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

struct Environment {
    let api: Networking
    let users: UserProviding
}

extension Environment {
    static let live = Environment(
        api: URLSessionNetworking(),
        users: InMemoryUsers()
    )
}

var CurrentEnvironment: Environment = .live
