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

struct SwitchPersistableKey {
    let first  = "first"
    let second = "second"
    let third  = "third"
}

class SwitchViewController: UITableViewController {

    @IBOutlet private weak var firstSwitch: UISwitch!
    @IBOutlet private weak var secondSwitch: UISwitch!
    @IBOutlet private weak var thirdSwitch: UISwitch!

    private let disposeBag = DisposeBag()
    private let userDefault = UserDefaults()
    private let key = SwitchPersistableKey()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期設定
        setupUI()
        setupRx()
    }

    private func setupUI() -> Void {
        firstSwitch.isOn    = userDefault.bool(forKey: key.first)
        secondSwitch.isOn   = userDefault.bool(forKey: key.second)
        thirdSwitch.isOn    = userDefault.bool(forKey: key.third)
    }

    private func setupRx() -> Void {
        firstSwitch.rx
            .isOn
            .subscribe { [unowned self] on in
                print(on)
                if let on = on.element, on {
                    self.unlockSwitch()
                } else {
                    self.secondSwitch.isOn = false
                    self.thirdSwitch.isOn = false
                    self.lockSwitch()
                }
                self.persistAll()
            }.addDisposableTo(disposeBag)

        secondSwitch.rx
            .isOn
            .filter { [unowned self] _ in
                return self.firstSwitch.isOn
            }
            .subscribe { [unowned self] on in
                print(on)
                if let on = on.element {
                    self.userDefault.set(on, forKey: self.key.second)
                }
            }
            .addDisposableTo(disposeBag)

        thirdSwitch.rx
            .isOn
            .filter { [unowned self] _ in
                return self.firstSwitch.isOn
            }
            .subscribe { [unowned self] on in
                print(on)
                if let on =  on.element {
                    self.userDefault.set(on, forKey: self.key.third)
                }
            }
            .addDisposableTo(disposeBag)
    }

    private func unlockSwitch() -> Void {
        firstSwitch.isEnabled   = true
        secondSwitch.isEnabled  = true
        thirdSwitch.isEnabled   = true
    }

    private func lockSwitch() -> Void {
        secondSwitch.isEnabled   = false
        thirdSwitch.isEnabled    = false
    }

    private func persistAll() -> Void {
        userDefault.set(firstSwitch.isOn, forKey: key.first)
        userDefault.set(secondSwitch.isOn, forKey: key.second)
        userDefault.set(thirdSwitch.isOn, forKey: key.third)
    }

}


