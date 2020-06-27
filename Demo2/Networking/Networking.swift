//
//  Networking.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

protocol Networking {
    func fetchPosts(completion: (Result<[Post], Error>) -> Void)
    func fetchPosts(for userId: Int, completion: (Result<[Post], Error>) -> Void)
    func fetchComments(for post: Post, completion: (Result<[Comment], Error>) -> Void)
    func fetchUser(using userId: Int, completion: (Result<User, Error>) -> Void)
}
