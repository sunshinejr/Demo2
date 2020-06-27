//
//  UIView.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

extension UIView {
    func add(subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}

extension UIView {
    func pin(to view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
        ])
    }

    func center(in view: UIView) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    func constraint(to size: CGSize) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
        ])
    }
}

extension UIView {
    func showAnimated(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        alpha = 0.0
        isHidden = false

        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }) { _ in
            self.isHidden = false
            completion?()
        }
    }

    func hideAnimated(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }) { _ in
            self.isHidden = true
            completion?()
        }
    }
}
