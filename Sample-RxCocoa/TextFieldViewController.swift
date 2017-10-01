//
//  TextFieldViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/09/26.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!

    let disposeBug = DisposeBag()
    let minimum: UInt = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    func setupRx() -> Void {
        textField.rx
            .text
            .orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [unowned self] query in
                if (query.element?.count)! < Int(self.minimum) {
                    self.textLabel.text = "Please enter more than 6 letters😅"
                } else {
                    self.textLabel.text = "Please tap the button👆"
                }
                self.button.isHidden = (query.element?.count)! < Int(self.minimum)
                self.button.isEnabled = (query.element?.count)! >= Int(self.minimum)
            }
            .addDisposableTo(disposeBug)

        button.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                print("did Tap")
                self?.close()
            }
            .addDisposableTo(disposeBug)
    }

    func close() -> Void {
        navigationController?.popToRootViewController(animated: true)
    }

}
