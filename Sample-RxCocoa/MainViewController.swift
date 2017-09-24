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

class MainViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    fileprivate var topics = [String]()
    fileprivate var shownTopics = [TableViewController.identifier(),
                                   SwitchViewController.identifier(),
                                   SearchBarViewController.identifier(),
                                   SliderViewController.identifier()]
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        setAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private

    fileprivate func setAction() {
        tableView.rx
            .itemSelected
            .map { [unowned self] in
                self.shownTopics[$0.row]
            }
            .subscribe { [unowned self] in
                if let identifier = $0.element {
                    let storybord = UIStoryboard(name: "Main", bundle: nil)
                    let dest = storybord.instantiateViewController(withIdentifier: identifier)
                    self.present(dest, animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
        }

}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topic", for: indexPath)
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

