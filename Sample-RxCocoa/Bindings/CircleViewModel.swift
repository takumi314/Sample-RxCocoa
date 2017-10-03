//
//  CircleViewModel.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/10/04.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ChameleonFramework

class CircleViewModel {

    var centerVariable = Variable<CGPoint>(.zero)   // Create one variable that will be changed and observed
    var backgroundColor: Observable<UIColor>!       // Create observable that will change backgroundColor based on center

    init() {
        setup()
    }

    func setup() -> Void {
        // When we get new center, emit new UIColor
        backgroundColor = centerVariable
            .asObservable()
            .map { center in
                let red: CGFloat = (center.x + center.y).truncatingRemainder(dividingBy: 255.0) / 255.0 // We just manipulate red, but you can do w/e
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0

                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
            }

    }

}


