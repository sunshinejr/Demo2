//
//  LoaderViewController.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

final class LoaderViewController: UIViewController {
    private let loader: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = false

        return spinner
    }()

    private let vibrancyView: UIVisualEffectView = {
        let vibrancy = UIVibrancyEffect()
        let vibrancyView = UIVisualEffectView(effect: vibrancy)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false

        return vibrancyView
    }()

    private lazy var blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        vibrancyView.effect = UIVibrancyEffect(blurEffect: blur)

        vibrancyView.contentView.addSubview(contentView)
        blurView.contentView.addSubview(vibrancyView)

        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = .clear
        blurView.alpha = 0.95
        blurView.layer.cornerRadius = 24.0
        blurView.clipsToBounds = true

        return blurView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addSubview(loader)

        return view
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        view.addSubview(blurView)

        self.view = view

        loader.center(in: contentView)
        contentView.pin(to: vibrancyView.contentView)
        vibrancyView.contentView.pin(to: blurView.contentView)
        blurView.center(in: view)
        blurView.constraint(to: .size(80.0))
    }

    func startLoading() {
        loader.startAnimating()
        view.showAnimated()
    }

    func stopLoading() {
        view.hideAnimated {
            self.loader.stopAnimating()
        }
    }
}
