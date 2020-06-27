//
//  UITableViewCell.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func fixForSelfSizingBiggerThenDefaultCell(in tableView: UITableView) {
        bounds = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 999.0)
        contentView.bounds = bounds
    }
}
