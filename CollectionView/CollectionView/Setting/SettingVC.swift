//
//  SettingVC.swift
//  CollectionView
//
//  Created by Nick Lin on 2018/7/30.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

enum SectionTitle: String {
    case aboutYou = "關於您"
    case aboutMe = "關於我"
}

enum SectionItem: String {
    case yourFace = "您的臉"
    case yourEye = "您的眼睛"
    case yourHeart = "您的心"
    case myFace = "我的臉"
    case myEye = "我的眼睛"
    case myHeart = "我的心"

}

struct SettingSection: SectionProtocol {
    let title: SectionTitle
    var items: [SectionItem]

    init(title: SectionTitle, items: [SectionItem]) {
        self.items = items
        self.title = title
    }
}

final class SettingDatas: SettingData<SettingSection> {

    override init() {
        super.init()
        self.sections = [
            SettingSection(title: .aboutYou,
                           items: [.yourEye,
                                   .yourFace,
                                   .yourHeart,
                                   .myEye,
                                   .myHeart

                ]),
            SettingSection(title: .aboutMe,
                           items: [.myFace
                ]),
            SettingSection(title: .aboutMe, items: [
                .yourEye,
                .myEye
                ])
        ]
    }

}

final class SettingVC: UIViewController {

    private let tableView: UITableView = UITableView(frame: .zero, style: UITableViewStyle.grouped)
    fileprivate lazy var settingData: SettingDatas = SettingDatas()

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

extension SettingVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return settingData.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingData.numberOfItem(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = settingData.item(for: indexPath)
        let cell = tableView.dequeueCell(type: SettingTableViewCell.self)
        cell.textLabel?.text = item.rawValue
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = settingData.item(for: indexPath)
        print(indexPath)
        print(item.rawValue)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return settingData.section(for: section).title.rawValue.isEmpty ? 0 : 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if settingData.section(for: section).title.rawValue.isEmpty { return nil }
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.9)
        let label = UILabel()
        label.text = settingData.section(for: section).title.rawValue
        view.addSubview(label)
        label.mLay(pin: .init(top: 10, left: 10, bottom: 10, right: 10))
        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
