//
//  MultiFoldingVC.swift
//  CollectionView
//
//  Created by 林智浩 on 2018/7/31.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

enum Level {
    case first
    case secound
}
struct ExpandData {
    let title: String
    let level: Level
}

final class MultiFoldingVC: UIViewController {

    private var dataDics: [String: [ExpandData]] = [
        "001":
            [ExpandData(title: "001", level: .secound),
             ExpandData(title: "002", level: .secound)],
        "002":
            [ExpandData(title: "001", level: .secound),
             ExpandData(title: "002", level: .secound)]
        ]
    var datas: [ExpandData] = [ExpandData(title: "001", level: .first),
                               ExpandData(title: "002", level: .first)]
    private let tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.mLay(pin: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(type: UITableViewCell.self)
    }
}

extension MultiFoldingVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: UITableViewCell.self)
        cell.selectionStyle = .none
        let data = datas[indexPath.item]
        if data.level == .first {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .blue
        }
        cell.textLabel?.text = data.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.item]
        if data.level == .first {
            // 判斷要展開還是縮起來

            // 要展開
            if indexPath.row == datas.count - 1 {
                let thisData = datas[indexPath.row]
                if thisData.level == .first, let newDatas = dataDics[thisData.title] {
                    var newIndex: [IndexPath] = []
                    for i in 1...newDatas.count {
                        newIndex.append(IndexPath(item: indexPath.item + i, section: indexPath.section))
                    }
                    datas.insert(contentsOf: newDatas, at: indexPath.item + 1)
                    tableView.beginUpdates()
                    tableView.insertRows(at: newIndex, with: .automatic)
                    tableView.endUpdates()

                }
            } else if let nextData = datas[safe: indexPath.item + 1],
                nextData.level == .first,
                let newDatas = dataDics[data.title] {
                    var newIndex: [IndexPath] = []
                    for i in 1...newDatas.count {
                        newIndex.append(IndexPath(item: indexPath.item + i, section: indexPath.section))
                    }
                    datas.insert(contentsOf: newDatas, at: indexPath.item + 1)
                    tableView.beginUpdates()
                    tableView.insertRows(at: newIndex, with: .automatic)
                    tableView.endUpdates()
                // 要縮
            } else {
                let rows = datas.count - indexPath.row

                var removeIndexs: [IndexPath] = []
                for i in 1...rows {
                    let index = IndexPath(item: indexPath.row + i, section: indexPath.section)
                    guard let nextData = datas[safe: index.row], nextData.level != .first else {
                        break
                    }
                    removeIndexs.append(index)
                }

                for index in removeIndexs.reversed() {
                    print(index)
                    datas.remove(at: index.row)
                }
                tableView.beginUpdates()
                tableView.deleteRows(at: removeIndexs, with: .automatic)
                tableView.endUpdates()
            }
        }

    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return (0 <= index && index < count) ? self[index] : nil
    }
}
