//
//  CommentTableViewCell.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class CommentTableViewCell: UITableViewCell, Reusable {
    private let author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .headline)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        return label
    }()

    private let body: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .footnote)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [author, body])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)

        return stackView
    }()

    var viewModel: CommentListItemViewModeling? {
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
        contentStackView.pin(to: contentView, insets: .init(top: 16.0, left: 48.0, bottom: 16.0, right: 16.0))

        selectionStyle = .none
        contentView.backgroundColor = .demoGray
        separatorInset = .only(left: 48.0)
    }

    private func updateView(using viewModel: CommentListItemViewModeling?) {
        body.text = viewModel?.body
        if let author = viewModel?.author {
            self.author.text = "\(author) \(localized("says")):"
        } else {
            author.text = ""
        }
        setNeedsLayout()
        layoutIfNeeded()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        UIView.animate(withDuration: 0.2) {
            self.contentView.backgroundColor = .white
        }

        viewModel?.didTapComment?()

        UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
            self.contentView.backgroundColor = .demoGray
        })
    }
}
