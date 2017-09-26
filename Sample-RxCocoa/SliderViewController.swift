//
//  SliderViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/09/25.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SliderViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var label: UILabel!

    let disposeBug = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRx()
    }

    func setupUI() -> Void {
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.value = 50
        slider.minimumTrackTintColor = .blue
    }

    func setupRx() -> Void {
        slider.rx
            .value
            .distinctUntilChanged {
                return abs($0 - $1) < 1
            }
            .subscribe { [unowned self] value in
                self.label.text = Int(value.element!).description
            }
            .addDisposableTo(disposeBug)
    }

}
