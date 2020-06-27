//
//  ViewController.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class TableViewController: UIViewController {
    private let loader: LoaderViewController = {
        let loader = LoaderViewController()
        loader.view.translatesAutoresizingMaskIntoConstraints = false

        return loader
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private let viewModel: CommonViewModeling

    init(viewModel: CommonViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(tableView)
        add(loader, to: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        render(using: viewModel.state)

        viewModel.register(object: self, for: Action { [weak self] in
            guard let self = self else { return }

            self.render(using: self.viewModel.state)
        })
    }

    private func render(using state: CommonState) {
        NSLog("state \(state)")
        DispatchQueue.main.async {
            switch state {
            case .loading:
                self.presentLoader()
            case let .content(items):
                self.present(items: items)
            case let .error(error):
                self.present(error: error)
            }
        }
    }

    private func present(error: ErrorModel) {
        loader.stopLoading()
        present(UIAlertController.error(error), animated: true, completion: nil)
    }

    private func present(items: [ListItem]) {
        loader.stopLoading()
    }

    private func presentLoader() {
        loader.startLoading()
    }
}
