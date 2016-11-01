//
//  HomeViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actions"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let data = AppData.all[indexPath.row]
        cell.textLabel?.text = data.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = AppData.all[indexPath.row]
        let controller = storyboard!.instantiateViewController(withIdentifier: data.storybordIdentifier)
        navigationController?.pushViewController(controller, animated: true)
    }
}
