//
//  PostViewModel.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

protocol PostViewModeling: ViewModeling {
    var title: String { get }
    var body: String { get }
    var author: String? { get }
    var more: ButtonAction? { get }

    var didTapPost: (() -> Void)? { get }
}

final class PostViewModel: PostViewModeling, Equatable {
    var title: String { post.title }
    var body: String { post.body }
    let didTapPost: (() -> Void)?
    var more: ButtonAction? = nil

    private(set) var author: String?
    private var updateCallbacks = NSMapTable<AnyObject, Action>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    private let post: Post
    private let didTapMore: ((User) -> Void)?
    private let api: Networking
    private let users: UserProviding

    init(post: Post, api: Networking = CurrentEnvironment.api, users: UserProviding = CurrentEnvironment.users, didTapMore: ((User) -> Void)?, didTapPost: (() -> Void)?) {
        self.post = post
        self.api = api
        self.users = users
        self.didTapMore = didTapMore
        self.didTapPost = didTapPost

        loadAuthor()
    }

    func register(object: AnyObject, for updateCallback: Action) {
        updateCallbacks.setObject(updateCallback, forKey: object)
    }

    private func loadAuthor() {
        if let author = users.user(for: post.userId) {
            self.author = author.name
            setMore(for: author)
        } else {
            api.fetchUser(using: post.userId) { [weak self] result in
                guard let self = self, let author = try? result.get() else { return }

                self.author = author.name
                self.users.save(user: author)
                self.setMore(for: author)
                self.notifyAboutUpdating()
            }
        }
    }

    private func setMore(for author: User) {
        more = ButtonAction(name: "More by this author") { [weak self] in
            self?.didTapMore?(author)
        }
    }

    private func notifyAboutUpdating() {
        updateCallbacks.objectEnumerator()?.forEach { callback in
            guard let callback = callback as? Action else { return }

            DispatchQueue.main.async {
                callback()
            }
        }
    }

    static func == (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        return lhs.post == rhs.post
    }
}
