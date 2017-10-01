//
//  SwitchViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/09/25.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SwitchViewController: UITableViewController {

    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secondSwitch: UISwitch!
    @IBOutlet weak var thirdSwitch: UISwitch!
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期設定
        setupUI()
        setupRx()
    }

    private func setupUI() -> Void {
    }

    private func setupRx() -> Void {
        firstSwitch.rx
            .isOn
            .subscribe { [unowned self] on in
                print(on)
            }.addDisposableTo(disposeBag)

        secondSwitch.rx
            .isOn
            .filter { [unowned self] _ in
                return self.firstSwitch.isOn
            }
            .subscribe { [unowned self] on in
                print(on)
            }
            .addDisposableTo(disposeBag)

        thirdSwitch.rx
            .isOn
            .filter { [unowned self] _ in
                return self.firstSwitch.isOn
            }
            .subscribe { [unowned self] on in
                print(on)
            }
            .addDisposableTo(disposeBag)

    }

}


