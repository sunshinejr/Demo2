//
//  TappableButton.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class TappableButton: UIButton {
    var tapAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    @objc private func didTap() {
        tapAction?()
    }
}
