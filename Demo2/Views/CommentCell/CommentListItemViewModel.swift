//
//  CommentViewModel.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import Foundation

protocol CommentListItemViewModeling: ViewModeling {
    var body: String { get }
    var author: String { get }

    var didTapComment: (() -> Void)? { get }
}

final class CommentListItemViewModel: CommentListItemViewModeling, Equatable {
    var body: String { comment.body }
    var author: String { "\(comment.name) (\(comment.email))" }
    let didTapComment: (() -> Void)?

    private var updateCallbacks = NSMapTable<AnyObject, Action>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    private let comment: Comment

    init(comment: Comment, didTapComment: (() -> Void)?) {
        self.comment = comment
        self.didTapComment = didTapComment
    }

    func register(object: AnyObject, for updateCallback: Action) {
        updateCallbacks.setObject(updateCallback, forKey: object)
    }

    private func notifyAboutUpdating() {
        updateCallbacks.objectEnumerator()?.forEach { callback in
            guard let callback = callback as? Action else { return }

            DispatchQueue.main.async {
                callback()
            }
        }
    }

    static func == (lhs: CommentListItemViewModel, rhs: CommentListItemViewModel) -> Bool {
        return lhs.comment == rhs.comment
    }
}
