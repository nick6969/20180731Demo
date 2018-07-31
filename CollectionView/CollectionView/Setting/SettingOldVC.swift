//
//  SettingOldVC.swift
//  CollectionView
//
//  Created by Nick Lin on 2018/7/30.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

final class SettingOldVC: UIViewController {

    private let tableView: UITableView = UITableView(frame: .zero, style: UITableViewStyle.grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.mLay(pin: .zero)
        tableView.registerCell(type: SettingTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

}

extension SettingOldVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: SettingTableViewCell.self)
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                cell.textLabel?.text = "您的臉"
            } else if indexPath.item == 1 {
                cell.textLabel?.text = "您的眼睛"
            } else if indexPath.item == 2 {
                cell.textLabel?.text = "您的心"
            }
        } else if indexPath.section == 1 {
            if indexPath.item == 0 {
                cell.textLabel?.text = "我的臉"
            } else if indexPath.item == 1 {
                cell.textLabel?.text = "我的眼睛"
            } else if indexPath.item == 2 {
                cell.textLabel?.text = "我的心"
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins )) {
            cell.layoutMargins = .zero
        }

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.9)
        let label = UILabel()
        if section == 0 {
            label.text = "關於您"
        } else if section == 1 {
            label.text = "關於我"
        }
        view.addSubview(label)
        label.mLay(pin: .init(top: 10, left: 10, bottom: 10, right: 10))
        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
