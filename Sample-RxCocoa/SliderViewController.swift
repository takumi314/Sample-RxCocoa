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

    let max: Float = 100.0
    let min: Float = 0.0
    let disposeBug = DisposeBag()

    var currentValue: Float = 50 {
        didSet {
            self.label.text = String(Int(currentValue))
            self.slider.value = currentValue
            self.stepper.value = Double(currentValue)
        }
    }
    
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

        stepper.value = 50
        stepper.stepValue = 1
        stepper.maximumValue = Double(max)
        stepper.minimumValue = Double(min)
    }

    func setupRx() -> Void {
        slider.rx
            .value
            .distinctUntilChanged {
                return abs($0 - $1) < 1
            }
            .subscribe { [unowned self] value in
                self.label.text = Int(value.element!).description
        stepper.rx
            .value
            .filter { [unowned self] x in
                self.min <= Float(x) || Float(x) <= self.max
            }
            .subscribe { [weak self] value in
                self?.currentValue = Float(value.element!)
            }
            .addDisposableTo(disposeBug)
    }

}
