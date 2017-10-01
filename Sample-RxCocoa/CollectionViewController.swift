//
//  CollectionViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/09/25.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    let disposeBug = DisposeBag()

    var items = [String]()
    var shownItems = [1, 2, 3, 4, 5, 6, 7]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.dataSource = self
    }

    func setup() -> Void {
        collectionView.rx
            .itemSelected
            .map { [unowned self] in
                let item = self.shownItems[$0.row]
                print(item)
            }
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBug)
    }

}

extension CollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shownItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = UILabel(frame: cell.frame)
        label.text = shownItems[indexPath.row].description
        cell.addSubview(label)

        return cell
    }

}
