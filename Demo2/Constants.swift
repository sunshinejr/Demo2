//
//  Constants.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

enum Constants {
    enum API {
        static let baseUrl = URL(string: "https://jsonplaceholder.typicode.com/")!
        static let postsUrl = baseUrl.appendingPathComponent("posts")

        static func postsUrl(for userId: Int) -> URL {
            // since it's an int we shouldn't need to worry about encoding it properly
            return postsUrl.appendingPathComponent("?userId=\(userId)", isDirectory: false)
        }

        static func commentsUrl(for postId: Int) -> URL {
            return postsUrl.appendingPathComponent("\(postId)", isDirectory: true).appendingPathComponent("comments", isDirectory: true)
        }

        static func userUrl(for userId: Int) -> URL {
            return baseUrl.appendingPathComponent("users", isDirectory: true).appendingPathComponent("\(userId)", isDirectory: true)
        }
    }
}
