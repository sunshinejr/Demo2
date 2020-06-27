//
//  Reusable.swift
//  Demo2
//
//  Created by Łukasz Mróz on 27/06/2020.
//  Copyright © 2020 Sunshinejr. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableView {
    func register(cell: (Reusable & UITableViewCell).Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func register(cells: (Reusable & UITableViewCell).Type...) {
        cells.forEach(register(cell:))
    }

    func dequeue<CellType: Reusable>(cell: CellType.Type, indexPath: IndexPath) -> CellType {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! CellType
    }
}
