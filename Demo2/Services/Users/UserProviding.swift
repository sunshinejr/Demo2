//
//  UserProviding.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

protocol UserProviding {
    func user(for userId: Int) -> User?
    func save(user: User)
}
