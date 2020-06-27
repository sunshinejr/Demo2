//
//  InMemoryUsers.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

final class InMemoryUsers: UserProviding {
    private var users = Set<User>()

    func user(for userId: Int) -> User? {
        return users.first { $0.id == userId }
    }

    func save(user: User) {
        if let oldUser = self.user(for: user.id) {
            users.remove(oldUser)
        }

        users.insert(user)
    }
}
