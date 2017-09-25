//
//  SearchBarViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/09/25.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBarViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let disposeBug = DisposeBag()
    let allCities = ["London", "Paris", "Berlin", "Rome", "Madrid", "Bern"]

    var shownItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        tableView.dataSource = self
    }

    func setupRx() -> Void {
        searchBar.rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe({ [unowned self] (query) in
                self.shownItems = self.allCities.filter({ $0.hasPrefix(query.element!) })
                self.tableView.reloadData()
            })
            .addDisposableTo(disposeBug)
    }
    
}

extension SearchBarViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  shownItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shownItems[indexPath.row]

        return cell
    }

}
