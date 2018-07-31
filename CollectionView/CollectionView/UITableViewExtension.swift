//
//  UITableViewExtension.swift
//  CollectionView
//
//  Created by Nick Lin on 2018/7/30.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }

    func registerCells<T: UITableViewCell>(types: [T.Type]) {
        types.forEach { registerCell(type: $0) }
    }

    func dequeueCell<T: UITableViewCell>(type: T.Type) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableCell(withIdentifier: String(describing: type)) as! T
        // swiftlint:enable force_cast
    }
}
