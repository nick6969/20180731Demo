//
//  SettingData.swift
//  CollectionView
//
//  Created by Nick Lin on 2018/7/30.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

protocol SettingDataProtocol {
    associatedtype Section: SectionProtocol
    var sections: [Section] { get set }
    func indexPath(for key: Section.Item) -> IndexPath
    func numberOfSections() -> Int
    func numberOfItem(in section: Int) -> Int
    func item(for indexPath: IndexPath) -> Section.Item
    func section(for index: Int) -> Section
}

protocol SectionProtocol {
    associatedtype Item: Equatable
    var items: [Item] { get set }
}

class SettingData<T: SectionProtocol>: SettingDataProtocol {
    var sections: [T] = []
}

extension SettingDataProtocol {

    func indexPath(for key: Section.Item) -> IndexPath {
        for (indexSection, section) in sections.enumerated() {
            if let indexItem = section.items.index(of: key) {
                return IndexPath(item: indexItem, section: indexSection)
            }
        }
        assert(false, "使用了沒有在顯示陣列裡的 Key")
        return IndexPath(item: Int.max, section: Int.max)
    }

    func numberOfSections() -> Int {
        return self.sections.count
    }

    func numberOfItem(in section: Int) -> Int {
        return self.sections[section].items.count
    }

    func item(for indexPath: IndexPath) -> Section.Item {
        return self.section(for: indexPath.section).items[indexPath.item]
    }

    func section(for index: Int) -> Section {
        return self.sections[index]
    }

}
