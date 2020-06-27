//
//  TableViewDataSource.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var items = [ListItem]()
    private weak var tableView: UITableView?

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()

        tableView.dataSource = self
        tableView.delegate = self
        [PostTableViewCell.self, CommentTableViewCell.self].forEach(tableView.register(cell:))
    }

    func load(items: [ListItem]) {
        self.items = items

        #warning("TODO: Use better diffing algorithm instead of reloading everything")
        tableView?.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = items[indexPath.row]

        switch model {
        case let .post(post):
            let cell = tableView.dequeue(cell: PostTableViewCell.self, indexPath: indexPath)
            cell.fixForSelfSizingBiggerThenDefaultCell(in: tableView)
            cell.viewModel = post
            return cell
        case let .comment(comment):
            let cell = tableView.dequeue(cell: CommentTableViewCell.self, indexPath: indexPath)
            cell.fixForSelfSizingBiggerThenDefaultCell(in: tableView)
            cell.viewModel = comment
            return cell
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
