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
}

extension Environment {
    static let live = Environment(
        api: URLSessionNetworking()
    )
}

var CurrentEnvironment: Environment = .live
