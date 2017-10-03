//
//  PanGestureViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/10/04.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import Foundation
import UIKit

class PanGestureViewController: UIViewController {

    var circleView: UIView!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        circleView.center = next
    }

}
