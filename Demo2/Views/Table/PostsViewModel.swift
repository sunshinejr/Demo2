//
//  PostsViewModel.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

protocol PostsNavigating: AnyObject {
    func didTapMore(by user: User)
    func didTapDetails(of post: Post)
}

final class PostsViewModel: ListViewModeling {
    var state: ListState
    var title: String

    private var updateCallbacks = NSMapTable<AnyObject, Action>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    private let api: Networking
    private let fromUser: User?
    private weak var navigation: PostsNavigating?

    init(fromUser: User? = nil, api: Networking = CurrentEnvironment.api, navigation: PostsNavigating) {
        self.fromUser = fromUser
        self.api = api
        self.navigation = navigation

        title = fromUser.map { localized("%@'s Posts").replacingOccurrences(of: "%@", with: $0.name) } ?? localized("Posts")
        state = .loading
        fetchContent()
    }

    func register(object: AnyObject, for updateCallback: Action) {
        updateCallbacks.setObject(updateCallback, forKey: object)
    }

    func refresh() {
        fetchContent()
    }

    private func fetchContent() {
        update(state: .loading)

        let completion: (Result<[Post], Error>) -> Void = { [weak self] result in
            switch result {
            case let .success(posts):
                self?.updateState(with: posts)
            case let .failure(error):
                self?.updateState(with: error)
            }
        }

        if let fromUser = fromUser {
            api.fetchPosts(from: fromUser, completion: completion)
        } else {
            api.fetchPosts(completion: completion)
        }
    }

    private func updateState(with posts: [Post]) {
        let items: [ListItem] = posts.map { post in
            #warning("TODO: User storage + loading if needed")
            let postViewModel = PostListItemViewModel(post: post,
                                                      didTapMore: { [weak self] user in
                                                          self?.navigation?.didTapMore(by: user)
                                                      },
                                                      didTapPost: { [weak self] in
                                                          self?.navigation?.didTapDetails(of: post)
                                                      })
            return .post(postViewModel)
        }
        update(state: .content(items))
    }

    private func updateState(with error: Error) {
        let title = localized("Error")
        let description = localized("There was a problem when fetching the content. Please try again.")
        let cancelAction = AlertAction(name: localized("Cancel"), style: .cancel, action: nil)
        let retryAction = AlertAction(name: localized("Retry"), style: .default, action: { [weak self] in
            self?.fetchContent()
        })
        let model = ErrorModel(title: title, description: description, actions: [cancelAction, retryAction])
        update(state: .error(model))
    }

    private func update(state: ListState) {
        guard self.state != state else { return }

        self.state = state
        notifyAboutUpdating()
    }

    private func notifyAboutUpdating() {
        updateCallbacks.objectEnumerator()?.forEach { callback in
            guard let callback = callback as? Action else { return }

            callback()
        }
    }
}
