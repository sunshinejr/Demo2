//
//  Networking.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case unknown
}

protocol Networking {
    #warning("API doesn't support pagination yet, though we should keep an eye on that")
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func fetchPosts(for user: User, completion: @escaping (Result<[Post], Error>) -> Void)
    func fetchComments(for post: Post, completion: @escaping (Result<[Comment], Error>) -> Void)
    func fetchUser(using userId: Int, completion: @escaping (Result<User, Error>) -> Void)
}
