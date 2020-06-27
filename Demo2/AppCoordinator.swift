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

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let controller = TableViewController(viewModel: PostsViewModel(navigation: self))
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: PostsNavigating {
    func didTapMore(by user: User) {

    }

    func didTapDetails(of post: Post) {

    }
}
