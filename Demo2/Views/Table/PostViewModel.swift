//
//  PostViewModel.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

final class PostViewModel: ListViewModeling {
    var title: String { post.title }
    var state: ListState

    private var updateCallbacks = NSMapTable<AnyObject, Action>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    private let api: Networking
    private let post: Post
    private weak var navigation: PostsNavigating?

    init(post: Post, api: Networking = CurrentEnvironment.api, navigation: PostsNavigating) {
        self.post = post
        self.api = api
        self.navigation = navigation

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
        api.fetchComments(for: post) { [weak self] result in
            switch result {
            case let .success(comments):
                self?.updateState(with: comments)
            case let .failure(error):
                self?.updateState(with: error)
            }
        }
    }

    private func updateState(with comments: [Comment]) {
        let postItem = PostListItemViewModel(post: post,
                                             didTapMore: { [weak self] user in
                                                 self?.navigation?.didTapMore(by: user)
                                             },
                                             didTapPost: nil)
        let commentItems: [ListItem] = comments.map { comment in
            return .comment(CommentListItemViewModel(comment: comment, didTapComment: nil))
        }
        update(state: .content([.post(postItem)] + commentItems))
    }

    private func updateState(with error: Error) {
        let title = localized("Error")
        let description = localized("There was a problem when fetching the comment section. Please try again.")
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
