//
//  ViewController.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class TableViewController: UIViewController {
    private let viewModel: CommonViewModeling

    init(viewModel: CommonViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        render(using: viewModel.state)
        view.backgroundColor = .red
        
        viewModel.register(object: self, for: Action { [weak self] in
            guard let self = self else { return }

            self.render(using: self.viewModel.state)
        })
    }

    private func render(using state: CommonState) {
        switch state {
        case .loading:
            NSLog("loading")
            break // present laoder
        case let .content(items):
            NSLog("content")
            break // fill table view
        case let .error(error):
            NSLog("error")
            break // present alert
        }
    }
}
