//
//  PostsViewModel.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

final class PostsViewModel: CommonViewModeling {
    var state: CommonState

    private(set) var updateCallbacks = NSMapTable<AnyObject, Action>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    private let api: Networking

    init(api: Networking = CurrentEnvironment.api) {
        self.api = api
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
        api.fetchPosts { [weak self] result in
            switch result {
            case let .success(posts):
                self?.updateState(with: posts)
            case let .failure(error):
                self?.updateState(with: error)
            }
        }
    }

    private func updateState(with posts: [Post]) {
        let items: [ListItem] = posts.map { post in
            #warning("TODO: User storage + loading if needed")
            return .post(title: post.title, body: post.body, author: "\(post.userId)", more: ButtonAction(name: localized("More by this author"), action: nil))
        }
        state = .content(items)
        notifyAboutUpdating()
    }

    private func updateState(with error: Error) {
        let title = localized("Error")
        let description = localized("There was a problem when fetching the content. Please try again.")
        let cancelAction = AlertAction(name: localized("Cancel"), style: .cancel, action: nil)
        let retryAction = AlertAction(name: localized("Retry"), style: .default, action: { [weak self] in
            self?.fetchContent()
        })
        let model = ErrorModel(title: title, description: description, actions: [cancelAction, retryAction])
        state = .error(model)
        notifyAboutUpdating()
    }

    private func notifyAboutUpdating() {
        updateCallbacks.objectEnumerator()?.forEach { callback in
            NSLog("object!")
            guard let callback = callback as? Action else { return }

            callback()
        }
    }
}
