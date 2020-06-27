//
//  PostTableViewCell.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell, Reusable {
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title1)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        return label
    }()

    private let body: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        return label
    }()

    private let author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .footnote)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        return label
    }()

    private let more: TappableButton = {
        let button = TappableButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .vertical)

        return button
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [author, title, body])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)

        return stackView
    }()

    var viewModel: PostViewModeling? {
        didSet {
            updateView(using: viewModel)
            viewModel?.register(object: self, for: Action { [weak self] in
                self?.updateView(using: self?.viewModel)
            })
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    private func setupView() {
        contentView.add(subviews: contentStackView)
        contentStackView.pin(to: contentView, insets: .all(16.0))
    }

    private func updateView(using viewModel: PostViewModeling?) {
        title.text = viewModel?.title
        body.text = viewModel?.body
        if let author = viewModel?.author {
            self.author.text = localized("By") + " \(author)"
        } else {
            author.text = ""
        }

        if let more = viewModel?.more {
            self.more.setTitle(more.name, for: .normal)
            self.more.tapAction = more.action
        } else {
            more.setTitle("", for: .normal)
            more.tapAction = nil
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        viewModel?.didTapPost?()
    }
}
