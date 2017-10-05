//
//  PanGestureViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/10/04.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PanGestureViewController: UIViewController {

    var circleView: UIView!
    let disposeBag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRx()
    }

    func setupUI() -> Void {
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)

        setupPanGesture()
    }

    func setupPanGesture() -> Void {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(PanGestureViewController.didMove(_:)))
        circleView.addGestureRecognizer(gesture)
    }

    func didMove(_ gesture: UIPanGestureRecognizer) -> Void {
        let next = gesture.location(in: view)
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.circleView.center = next
        }
    }

    func setupRx() -> Void {
        let circleViewModel = CircleViewModel()

        circleView.rx
            .observe(CGPoint.self, "center")
            .bind(to: circleViewModel.centerVariable)
            .addDisposableTo(disposeBag)

        circleViewModel.backgroundColor
            .subscribe { [weak self] backgroundColor in
                guard let `self` = self, let color = backgroundColor.element else {
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self.circleView.backgroundColor = color

                    // To get complementary color for given background color
                    let viewBackgroundColor = UIColor(complementaryFlatColorOf: color)

                    if viewBackgroundColor != color {
                        self.view.backgroundColor = viewBackgroundColor
                    }
                }
            }.addDisposableTo(disposeBag)
    }

}
