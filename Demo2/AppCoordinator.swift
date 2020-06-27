//
//  AppCoordinator.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private var navigation: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let controller = TableViewController(viewModel: PostsViewModel(navigation: self))
        let navigation = UINavigationController(rootViewController: controller)
        window.rootViewController = navigation
        window.makeKeyAndVisible()

        self.navigation = navigation
    }
}

extension AppCoordinator: PostsNavigating {
    func didTapMore(by user: User) {
        let controller = TableViewController(viewModel: PostsViewModel(fromUser: user, navigation: self))
        navigation?.pushViewController(controller, animated: true)
    }

    func didTapDetails(of post: Post) {
        let controller = TableViewController(viewModel: PostViewModel(post: post, navigation: self))
        navigation?.pushViewController(controller, animated: true)
    }
}
