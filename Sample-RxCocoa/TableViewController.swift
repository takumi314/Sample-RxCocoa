//
//  TableViewController.swift
//  Sample-RxCocoa
//
//  Created by NishiokaKohei on 2017/09/25.
//  Copyright © 2017年 Kohey.N. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!

    fileprivate var numbers = [1...30]
    fileprivate var shownItems = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setup() -> Void {
    }

}

extension TableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shownItems[indexPath.row].description
        cell.detailTextLabel?.text = "hoge"

        return cell
    }

}
