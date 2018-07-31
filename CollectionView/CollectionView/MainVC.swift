//
//  MainVC.swift
//  CollectionView
//
//  Created by Nick Lin on 2018/7/30.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

final class MainVC: UIViewController {

    private lazy var buttonClourse: ( (String) -> UIButton) = { title in
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle( title, for: .normal)
        button.addTarget(self, action: #selector(self.didTap(_:)), for: .touchUpInside)
        return button
    }

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(settingScreenOldButton)
        stackView.addArrangedSubview(settingScreenButton)
        stackView.addArrangedSubview(multiFoldingButton)
        return stackView
    }()

    lazy var settingScreenOldButton: UIButton = buttonClourse("設定畫面基本寫法")
    lazy var settingScreenButton: UIButton = buttonClourse("設定畫面特別寫法")
    lazy var multiFoldingButton: UIButton = buttonClourse("多層折疊")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackView)
        stackView.mLay(pin: .init(top: 100, left: 20, bottom: 60, right: 20))
    }

    @objc private func didTap(_ sender: UIButton) {
        switch sender {
        case settingScreenOldButton:
            let vc = SettingOldVC()
            vc.title = sender.title(for: .normal)
            self.navigationController?.pushViewController(vc, animated: true)
        case settingScreenButton:
            let vc = SettingVC()
            vc.title = sender.title(for: .normal)
            self.navigationController?.pushViewController(vc, animated: true)
        case multiFoldingButton:
            let vc = MultiFoldingVC()
            vc.title = sender.title(for: .normal)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
