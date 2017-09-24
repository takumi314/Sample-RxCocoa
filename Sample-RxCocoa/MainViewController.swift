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
    fileprivate var shownTopics = ["UITable", "UISearchBar", "UISlider", "UISwtch"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topic", for: indexPath)
        cell.textLabel?.text = shownTopics[indexPath.row]

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownTopics.count
    }

}



