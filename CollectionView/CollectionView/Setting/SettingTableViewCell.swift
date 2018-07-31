//
//  SettingTableViewCell.swift
//  CollectionView
//
//  Created by 林智浩 on 2018/7/31.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {

    let settingSwitch: UISwitch = UISwitch()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        accessoryView = settingSwitch
    }
}
