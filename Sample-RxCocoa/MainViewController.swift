//
//  MainViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/09/24.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ChameleonFramework

class MainViewController: UIViewController {

    fileprivate let shownTopics = [TableViewController.identifier(),
                                   SwitchViewController.identifier(),
                                   SearchBarViewController.identifier(),
                                   SliderViewController.identifier(),
                                   CollectionViewController.identifier(),
                                   TextFieldViewController.identifier()]
    fileprivate let disposeBag = DisposeBag()

    fileprivate var tableView: UITableView?
    fileprivate var topics = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MainViewController"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let size = view.frame.size
        let frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        tableView = UITableView(frame: frame)
        view.addSubview(tableView!)

        tableView!.dataSource = self
        addObservable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private methods

    fileprivate func addObservable() {
        didTapCell()
    }

    ///
    /// TableCellタップによる画面遷移
    ///
    func didTapCell() {
        tableView?.rx
            .itemSelected
            .map { [unowned self] in
                self.shownTopics[$0.row]
            }
            .subscribe { [unowned self] in
                print($0)
                if let identifier = $0.element {
                    let storybord = UIStoryboard(name: "Main", bundle: nil)
                    let dest = storybord.instantiateViewController(withIdentifier: identifier)
                    self.navigationController?.pushViewController(dest, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }

}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "topic")
        cell.textLabel?.text = shownTopics[indexPath.row]
        cell.tag = indexPath.row

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownTopics.count
    }

}

extension UIViewController {
    class func identifier() -> String {
        return self.className()
    }
}

extension NSObjectProtocol {
    static func className() -> String {
        return "\(self)"
    }
}

