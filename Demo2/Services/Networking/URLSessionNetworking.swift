//
//  URLSessionNetworking.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

final class URLSessionNetworking: Networking {
    let session: URLSession
    let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        request(url: Constants.API.postsUrl, completion: completion)
    }

    func fetchPosts(from user: User, completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = Constants.API.postsUrl(for: user.id) else {
            completion(.failure(NetworkingError.unknown))
            return
        }

        request(url: url, completion: completion)
    }

    func fetchComments(for post: Post, completion: @escaping (Result<[Comment], Error>) -> Void) {
        request(url: Constants.API.commentsUrl(for: post.id), completion: completion)
    }

    func fetchUser(using userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        request(url: Constants.API.userUrl(for: userId), completion: completion)
    }

    private func request<Model: Codable>(url: URL, completion: @escaping (Result<Model, Error>) -> Void) {
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            completion(self.parse(data: data, response: response, error: error))
        }
        task.resume()
    }

    private func parse<Model: Codable>(data: Data?, response: URLResponse?, error: Error?) -> Result<Model, Error> {
        #warning("TODO: Model metadata errors (e.g. using status codes)")
        if let data = data {
            do {
                let model = try decoder.decode(Model.self, from: data)
                return .success(model)
            } catch {
                return .failure(error)
            }
        } else if let error = error {
            return .failure(error)
        } else {
            return .failure(NetworkingError.unknown)
        }
    }
}
